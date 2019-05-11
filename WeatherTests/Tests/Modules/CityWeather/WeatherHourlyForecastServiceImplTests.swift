//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class WeatherHourlyForecastServiceImplTests: XCTestCase {
    private let cityId = 1234
    
    private var subject: WeatherHourlyForecastServiceImpl!
    private var apiService: ApiServiceMock!
    private var jsonDecoder: HourlyForecastJsonDecoderMock!
    
    override func setUp() {
        super.setUp()
        
        apiService = .init()
        jsonDecoder = .init()
        subject = WeatherHourlyForecastServiceImpl(apiService: apiService, jsonDecoder: jsonDecoder)
    }
    
    func testGetDailyForecastSuccess() {
        let data = Constants.data
        apiService.executeRequestReturnValue = Promise(data)
        
        let expectedWeathers = [HourWeather.weather1, .weather2]
        jsonDecoder.parseDataReturnValue = expectedWeathers
        
        let result = subject.getHourlyForecast(for: cityId)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(result.value, expectedWeathers)
        XCTAssertNil(result.error)
    }
    
    func testGetDailyForecastApiServiceFailure() {
        let expectedError = Constants.error
        apiService.executeRequestReturnValue = Promise(expectedError)
        
        let expectedWeathers = [HourWeather.weather1, .weather2]
        jsonDecoder.parseDataReturnValue = expectedWeathers
        
        let result = subject.getHourlyForecast(for: cityId)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(result.error as NSError?, expectedError)
        XCTAssertNil(result.value)
    }
    
    func testGetDailyForecastJsonDecoderFailure() {
        let data = Constants.data
        apiService.executeRequestReturnValue = Promise(data)
        
        let expectedError = Constants.error
        jsonDecoder.parseDataClosure = { _ in throw expectedError }
        
        let result = subject.getHourlyForecast(for: cityId)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(result.error as NSError?, expectedError)
        XCTAssertNil(result.value)
    }
}
