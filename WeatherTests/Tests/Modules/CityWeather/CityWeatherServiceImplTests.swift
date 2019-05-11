//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class CityWeatherServiceImplTests: XCTestCase {
    private let cityId = 123
    
    private var subject: CityWeatherServiceImpl!
    private var dailyForecastService: WeatherDailyForecastServiceMock!
    private var hourlyForecastService: WeatherHourlyForecastServiceMock!

    override func setUp() {
        super.setUp()
        
        dailyForecastService = .init()
        hourlyForecastService = .init()
        subject = CityWeatherServiceImpl(
            dailyForecastService: dailyForecastService,
            hourlyForecastService: hourlyForecastService
        )
    }
    
    func testGetDailyForecastSuccess() {
        let expectedWeathers = [DayWeather.weather1, .weather2]
        dailyForecastService.getDailyForecastForReturnValue = Promise(expectedWeathers)
        let receivedPromise = subject.getDailyForecast(for: cityId)
        
        XCTAssertEqual(dailyForecastService.getDailyForecastForCallsCount, 1, "should call daily forecast service once")
        XCTAssertEqual(dailyForecastService.getDailyForecastForReceivedCityId, cityId)
        XCTAssertEqual(receivedPromise.value, expectedWeathers)
        XCTAssertNil(receivedPromise.error)
    }
    
    func testGetDailyForecastFailure() {
        let expectedError = Constants.error
        dailyForecastService.getDailyForecastForReturnValue = Promise(expectedError)
        let receivedPromise = subject.getDailyForecast(for: cityId)
        
        XCTAssertEqual(dailyForecastService.getDailyForecastForCallsCount, 1, "should call daily forecast service once")
        XCTAssertEqual(dailyForecastService.getDailyForecastForReceivedCityId, cityId)
        XCTAssertEqual(receivedPromise.error as NSError?, expectedError)
        XCTAssertNil(receivedPromise.value)
    }
    
    func testGetHourlyForecastSuccess() {
        let expectedWeathers = [HourWeather.weather1, .weather2]
        hourlyForecastService.getHourlyForecastForReturnValue = Promise(expectedWeathers)
        let receivedPromise = subject.getHourlyForecast(for: cityId)
        
        XCTAssertEqual(hourlyForecastService.getHourlyForecastForCallsCount, 1, "should call hourly forecast service once")
        XCTAssertEqual(hourlyForecastService.getHourlyForecastForReceivedCityId, cityId)
        XCTAssertEqual(receivedPromise.value, expectedWeathers)
        XCTAssertNil(receivedPromise.error)
    }
    
    func testGetHourlyForecastFailure() {
        let expectedError = Constants.error
        hourlyForecastService.getHourlyForecastForReturnValue = Promise(expectedError)
        let receivedPromise = subject.getHourlyForecast(for: cityId)
        
        XCTAssertEqual(hourlyForecastService.getHourlyForecastForCallsCount, 1, "should call hourly forecast service once")
        XCTAssertEqual(hourlyForecastService.getHourlyForecastForReceivedCityId, cityId)
        XCTAssertEqual(receivedPromise.error as NSError?, expectedError)
        XCTAssertNil(receivedPromise.value)
    }
}
