//
//  Created by Dmitriy Stupivtsev on 28/04/2019.
//

import XCTest
@testable import Promises
@testable import Weather

final class CitiesWeatherServiceImplTests: XCTestCase {
    var subject: CitiesWeatherServiceImpl!
    var apiService: ApiServiceMock!
    var jsonDecoder: CitiesWeatherJsonDecoderMock!
    
    override func setUp() {
        super.setUp()
        
        apiService = .init()
        jsonDecoder = .init()
        subject = CitiesWeatherServiceImpl(apiService: apiService, jsonDecoder: jsonDecoder)
    }
    
    func testGetWeatherSuccess() {
        jsonDecoder.parseDataReturnValue = expectedCities
        
        apiService.executeRequestReturnValue = Promise<Data?>.pending()
        
        var receivedValue: [City]?
        var receivedError: Error?
        subject.getWeather(for: citiesIds)
            .then { receivedValue = $0 }
            .catch { receivedError = $0 }
        
        XCTAssertEqual(apiService.executeRequestCallsCount, 1, "should call apiService once")
        XCTAssertEqual(apiService.executeRequestReceivedRequest, request)
        
        let data = Constants.data
        apiService.executeRequestReturnValue.fulfill(data)
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(jsonDecoder.parseDataCallsCount, 1, "should call jsonDecoder once")
        XCTAssertEqual(jsonDecoder.parseDataReceivedData, data)
        
        XCTAssertEqual(receivedValue, expectedCities)
        XCTAssertNil(receivedError, "shouldn't receive error")
    }
    
    func testGetWeatherFailure() {
        let expectedError = Constants.error
        jsonDecoder.parseDataClosure = { _ in throw expectedError }
        
        apiService.executeRequestReturnValue = Promise<Data?>.pending()
        
        var receivedValue: [City]?
        var receivedError: Error?
        subject.getWeather(for: citiesIds)
            .then { receivedValue = $0 }
            .catch { receivedError = $0 }
        
        XCTAssertEqual(apiService.executeRequestCallsCount, 1, "should call apiService once")
        XCTAssertEqual(apiService.executeRequestReceivedRequest, request)
        
        let data = Constants.data
        apiService.executeRequestReturnValue.fulfill(data)
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(jsonDecoder.parseDataCallsCount, 1, "should call jsonDecoder once")
        XCTAssertEqual(jsonDecoder.parseDataReceivedData, data)
        
        XCTAssertNil(receivedValue, "shouldn't receive value")
        XCTAssertEqual(receivedError as NSError?, expectedError)
    }
}

private extension CitiesWeatherServiceImplTests {
    var expectedCities: [City] {
        [.city1, .city2]
    }
    
    var citiesIds: [String] {
        ["123", "42134", "asdfasd"]
    }
    
    var request: ApiServiceRequest {
        ApiServiceRequest(
            name: "group",
            parameters: [
                "id": citiesIds.joined(separator: ","),
                "units": "metric"
            ]
        )
    }
}
