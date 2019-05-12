//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class CityWeatherViewModelImplTests: XCTestCase {
    private var subject: CityWeatherViewModelImpl!
    private var citySource: CitySource!
    private var forecastService: ForecastServiceMock!
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
        formatter.formatForecastTemperatureReturnValue = "TestFormattedValue5"
        
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
    
    func testGetDailyForecastSourceSuccess() {
        let expectedForecast = [Forecast.forecast1, .forecast2]
        forecastService.getForecastForReturnValue = Promise(expectedForecast)
        
        let result = subject.getDailyForecastSource()
        
        XCTAssert(waitForPromises(timeout: 1))
        expect(actual: result.value, equalTo: expectedCellsModels)
        XCTAssertNil(result.error)
    }
    
    private func expect(actual: [CellProviderConvertible]?, equalTo expected: [DailyForecastCell.Model]) {
        let actualCellsModels = actual?.compactMap { $0 as? DailyForecastCell.Model }
        XCTAssertEqual(actualCellsModels, expected)
    }
    
    func testGetDailyForecastSourceFailure() {
        let expectedError = Constants.error
        forecastService.getForecastForReturnValue = Promise(expectedError)
        
        let result = subject.getDailyForecastSource()
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertNil(result.value)
        XCTAssertEqual(result.error as NSError?, expectedError)
    }
}

private extension CityWeatherViewModelImplTests {
    var expectedCellsModels: [DailyForecastCell.Model] {
        return [
            DailyForecastCell.Model(
                weekdayTitle: formatter.formatForecastWeekdayReturnValue,
                dateString: formatter.formatForecastDateReturnValue,
                weatherImage: UIImage(),
                maxTemperatureString: formatter.formatForecastTemperatureReturnValue,
                minTemperatureString: formatter.formatForecastTemperatureReturnValue
            ),
            DailyForecastCell.Model(
                weekdayTitle: formatter.formatForecastWeekdayReturnValue,
                dateString: formatter.formatForecastDateReturnValue,
                weatherImage: UIImage(),
                maxTemperatureString: formatter.formatForecastTemperatureReturnValue,
                minTemperatureString: formatter.formatForecastTemperatureReturnValue
            )
        ]
    }
}

extension DailyForecastCell.Model: Equatable {
    public static func == (lhs: DailyForecastCell.Model, rhs: DailyForecastCell.Model) -> Bool {
        return lhs.weekdayTitle == rhs.weekdayTitle
            && lhs.dateString == rhs.dateString
            && lhs.maxTemperatureString == rhs.maxTemperatureString
            && lhs.minTemperatureString == rhs.minTemperatureString
    }
}
