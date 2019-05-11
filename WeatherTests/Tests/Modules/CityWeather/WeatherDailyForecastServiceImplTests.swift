//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class WeatherDailyForecastServiceImplTests: XCTestCase {
    private let cityId = 1234
    
    private var subject: WeatherDailyForecastServiceImpl!
    private var apiService: ApiServiceMock!
    private var jsonDecoder: DailyForecastJsonDecoderMock!

    override func setUp() {
        super.setUp()
        
        apiService = .init()
        jsonDecoder = .init()
        subject = WeatherDailyForecastServiceImpl(apiService: apiService, jsonDecoder: jsonDecoder)
    }

    func testGetDailyForecastSuccess() {
        let data = Constants.data
        apiService.executeRequestReturnValue = Promise(data)
        
        let expectedWeathers = [DayWeather.weather1, .weather2]
        jsonDecoder.parseDataReturnValue = expectedWeathers
        
        let result = subject.getDailyForecast(for: cityId)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(result.value, expectedWeathers)
        XCTAssertNil(result.error)
    }
    
    func testGetDailyForecastApiServiceFailure() {
        let expectedError = Constants.error
        apiService.executeRequestReturnValue = Promise(expectedError)
        
        let expectedWeathers = [DayWeather.weather1, .weather2]
        jsonDecoder.parseDataReturnValue = expectedWeathers
        
        let result = subject.getDailyForecast(for: cityId)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(result.error as NSError?, expectedError)
        XCTAssertNil(result.value)
    }
    
    func testGetDailyForecastJsonDecoderFailure() {
        let data = Constants.data
        apiService.executeRequestReturnValue = Promise(data)
        
        let expectedError = Constants.error
        jsonDecoder.parseDataClosure = { _ in throw expectedError }
        
        let result = subject.getDailyForecast(for: cityId)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(result.error as NSError?, expectedError)
        XCTAssertNil(result.value)
    }
}
