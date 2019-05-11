//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class CityWeatherViewModelImplTests: XCTestCase {
    private var subject: CityWeatherViewModelImpl!
    private var citySource: CitySource!
    private var numberFormatter: NumberFormatterProtocolMock!
    private var dateFormatter: DateFormatterProtocolMock!
    private var cityWeatherService: CityWeatherServiceMock!
    
    override func setUp() {
        super.setUp()
        
        citySource = CitySource(city: .city1, timeZone: .current)
        
        numberFormatter = .init()
        numberFormatter.stringFromReturnValue = "NumberTest"
        
        dateFormatter = .init()
        dateFormatter.stringFromReturnValue = "DateTest"
        
        cityWeatherService = .init()
        
        subject = CityWeatherViewModelImpl(
            citySource: citySource,
            numberFormatter: numberFormatter,
            dateFormatter: dateFormatter,
            cityWeatherService: cityWeatherService
        )
    }
    
    func testCreateMainSource() {
        let receivedValue = subject.mainSource
        let expectedValue = CityWeatherViewSource.Main(
            cityName: citySource.city.name.uppercased(),
            temperatue: numberFormatter.stringFromReturnValue,
            degreeSymbol: "°",
            weatherStatus: citySource.city.weather.first!.description.uppercased(),
            dateString: dateFormatter.stringFromReturnValue.uppercased()
        )
        
        XCTAssertEqual(receivedValue, expectedValue)
        XCTAssertEqual(numberFormatter.stringFromCallsCount, 1, "expect to call number formatter once, got \(numberFormatter.stringFromCallsCount)")
        XCTAssertEqual(dateFormatter.stringFromCallsCount, 1, "expect to call date formatter once, got \(dateFormatter.stringFromCallsCount)")
    }
    
    func testGetDailyForecastSourceSuccess() {
        let expectedWeathers = [DayWeather.weather1, .weather2]
        cityWeatherService.getDailyForecastForReturnValue = Promise(expectedWeathers)
        
        let result = subject.getDailyForecastSource()
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEmpty(result.value)
        XCTAssertNil(result.error)
    }
    
    func testGetDailyForecastSourceFailure() {
        let expectedError = Constants.error
        cityWeatherService.getDailyForecastForReturnValue = Promise(expectedError)
        
        let result = subject.getDailyForecastSource()
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertNil(result.value)
        XCTAssertEqual(result.error as NSError?, expectedError)
    }
}
