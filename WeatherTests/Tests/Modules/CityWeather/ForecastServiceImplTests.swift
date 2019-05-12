//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class ForecastServiceImplTests: XCTestCase {
    private let cityId = 1234
    
    private var subject: ForecastServiceImpl!
    private var apiService: ApiServiceMock!
    private var jsonDecoder: ForecastJsonDecoderMock!
    
    override func setUp() {
        super.setUp()
        
        apiService = .init()
        jsonDecoder = .init()
        subject = ForecastServiceImpl(apiService: apiService, jsonDecoder: jsonDecoder)
    }
    
    func testGetDailyForecastSuccess() {
        let data = Constants.data
        apiService.executeRequestReturnValue = Promise(data)
        
        let expectedForecasts = [Forecast.forecast1, .forecast2]
        jsonDecoder.parseDataReturnValue = expectedForecasts
        
        let result = subject.getForecast(for: cityId)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(result.value, expectedForecasts)
        XCTAssertNil(result.error)
    }
    
    func testGetDailyForecastApiServiceFailure() {
        let expectedError = Constants.error
        apiService.executeRequestReturnValue = Promise(expectedError)
        
        let expectedForecasts = [Forecast.forecast1, .forecast2]
        jsonDecoder.parseDataReturnValue = expectedForecasts
        
        let result = subject.getForecast(for: cityId)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(result.error as NSError?, expectedError)
        XCTAssertNil(result.value)
    }
    
    func testGetDailyForecastJsonDecoderFailure() {
        let data = Constants.data
        apiService.executeRequestReturnValue = Promise(data)
        
        let expectedError = Constants.error
        jsonDecoder.parseDataClosure = { _ in throw expectedError }
        
        let result = subject.getForecast(for: cityId)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(result.error as NSError?, expectedError)
        XCTAssertNil(result.value)
    }
}
