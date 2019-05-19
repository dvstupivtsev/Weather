//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class CityWeatherViewModelImplTests: XCTestCase {
    private var subject: CityWeatherViewModelImpl!
    private var citySource: CitySource!
    private var forecastService: CityForecastServiceMock!
    private var formatter: CityWeatherFormatterMock!
    
    override func setUp() {
        super.setUp()
        
        citySource = CitySource(city: .city1, timeZone: .current)
        
        forecastService = .init()
        formatter = .init()
        formatter.formatCurrentDateReturnValue = "TestFormattedValue1"
        formatter.formatForecastDateReturnValue = "TestFormattedValue2"
        formatter.formatForecastWeekdayReturnValue = "TestFormattedValue3"
        formatter.formatTemperatureValueReturnValue = "TestFormattedValue4"
        formatter.formatHourlyForecastDateReturnValue = "TestFormattedValue5"
        formatter.formatForecastTemperatureReturnValue = "TestFormattedValue6"
        
        subject = CityWeatherViewModelImpl(
            citySource: citySource,
            forecastService: forecastService,
            formatter: formatter
        )
    }
    
    func testCreateMainSource() {
        let receivedValue = subject.mainSource
        let expectedValue = CityWeatherViewSource.Main(
            cityName: citySource.city.name.uppercased(),
            temperatue: formatter.formatTemperatureValueReturnValue,
            degreeSymbol: "°",
            weatherStatus: citySource.city.weather.first!.description.uppercased(),
            dateString: formatter.formatCurrentDateReturnValue.uppercased()
        )
        
        XCTAssertEqual(receivedValue, expectedValue)
        XCTAssertEqual(formatter.formatTemperatureValueCallsCount, 1, "expect to call number formatter once, got \(formatter.formatTemperatureValueCallsCount)")
        XCTAssertEqual(formatter.formatCurrentDateCallsCount, 1, "expect to call date formatter once, got \(formatter.formatCurrentDateCallsCount)")
    }
    
    func testGetForecastSourceSuccess() {
        forecastService.getForecastForReturnValue = Promise(cityForecast)
        
        let result = subject.getForecastSource()
        
        XCTAssert(waitForPromises(timeout: 1))
        expect(actual: result.value?.hourlyProviderConvertibles, equalTo: expectedHourlyForecastCellsModels)
        expect(actual: result.value?.dailyProviderConvertibles, equalTo: expectedDailyForecastCellsModels)
        XCTAssertNil(result.error)
    }
    
    private func expect(actual: [TableCellProviderConvertible]?, equalTo expected: [DailyForecastTableCell.Model]) {
        let actualCellsModels = actual?.compactMap { $0 as? DailyForecastTableCell.Model }
        XCTAssertEqual(actualCellsModels, expected)
    }
    
    private func expect(actual: [CollectionCellProviderConvertible]?, equalTo expected: [HourlyForecastCollectionCell.Model]) {
        let actualCellsModels = actual?.compactMap { $0 as? HourlyForecastCollectionCell.Model }
        XCTAssertEqual(actualCellsModels, expected)
    }
    
    func testGetForecastSourceFailure() {
        let expectedError = Constants.error
        forecastService.getForecastForReturnValue = Promise(expectedError)
        
        let result = subject.getForecastSource()
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertNil(result.value)
        XCTAssertEqual(result.error as NSError?, expectedError)
    }
}

private extension CityWeatherViewModelImplTests {
    var cityForecast: CityForecast {
        return CityForecast(
            hourlyForecast: [Forecast.forecast1, .forecast2],
            dailyForecast: [Forecast.forecast2, .forecast1]
        )
    }
    
    var expectedHourlyForecastCellsModels: [HourlyForecastCollectionCell.Model] {
        return [
            HourlyForecastCollectionCell.Model(
                dateString: formatter.formatHourlyForecastDateReturnValue,
                temperatureString: formatter.formatForecastTemperatureReturnValue,
                iconImage: UIImage()
            ),
            HourlyForecastCollectionCell.Model(
                dateString: formatter.formatHourlyForecastDateReturnValue,
                temperatureString: formatter.formatForecastTemperatureReturnValue,
                iconImage: UIImage()
            )
        ]
    }
    
    var expectedDailyForecastCellsModels: [DailyForecastTableCell.Model] {
        return [
            DailyForecastTableCell.Model(
                weekdayTitle: formatter.formatForecastWeekdayReturnValue,
                dateString: formatter.formatForecastDateReturnValue,
                weatherImage: UIImage(),
                maxTemperatureString: formatter.formatForecastTemperatureReturnValue,
                minTemperatureString: formatter.formatForecastTemperatureReturnValue
            ),
            DailyForecastTableCell.Model(
                weekdayTitle: formatter.formatForecastWeekdayReturnValue,
                dateString: formatter.formatForecastDateReturnValue,
                weatherImage: UIImage(),
                maxTemperatureString: formatter.formatForecastTemperatureReturnValue,
                minTemperatureString: formatter.formatForecastTemperatureReturnValue
            )
        ]
    }
}

extension DailyForecastTableCell.Model: Equatable {
    public static func == (lhs: DailyForecastTableCell.Model, rhs: DailyForecastTableCell.Model) -> Bool {
        return lhs.weekdayTitle == rhs.weekdayTitle
            && lhs.dateString == rhs.dateString
            && lhs.maxTemperatureString == rhs.maxTemperatureString
            && lhs.minTemperatureString == rhs.minTemperatureString
    }
}

extension HourlyForecastCollectionCell.Model: Equatable {
    public static func == (lhs: HourlyForecastCollectionCell.Model, rhs: HourlyForecastCollectionCell.Model) -> Bool {
        return lhs.temperatureString == rhs.temperatureString
            && lhs.dateString == rhs.dateString
    }
}
