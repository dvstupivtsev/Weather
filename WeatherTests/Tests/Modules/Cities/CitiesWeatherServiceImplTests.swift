//
//  Created by Dmitriy Stupivtsev on 28/04/2019.
//

import XCTest
@testable import Promises
@testable import Weather

final class CitiesWeatherServiceImplTests: XCTestCase {
    var apiService: ApiServiceMock!
    var subject: CitiesWeatherServiceImpl!
    
    override func setUp() {
        super.setUp()
        
        apiService = ApiServiceMock()
        subject = CitiesWeatherServiceImpl(apiService: apiService)
    }
    
    func testGetWeatherWithValidJson() {
        apiService.executeRequestReturnValue = Promise<Data?>.pending()
        
        var receivedValue: [City]?
        var receivedError: Error?
        subject.getWeather(for: citiesIds)
            .then { receivedValue = $0 }
            .catch { receivedError = $0 }
        
        XCTAssertEqual(
            apiService.executeRequestCallsCount,
            1,
            "should call apiService once, got \(apiService.executeRequestCallsCount)"
        )
        
        XCTAssertEqual(apiService.executeRequestReceivedRequest, request)
        
        apiService.executeRequestReturnValue.fulfill(validJson)
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(receivedValue, expectedCities)
        XCTAssertNil(receivedError, "shouldn't receive error")
    }
    
    func testGetWeatherWithInvalidJson() {
        apiService.executeRequestReturnValue = Promise<Data?>.pending()
        
        var receivedValue: [City]?
        var receivedError: Error?
        subject.getWeather(for: citiesIds)
            .then { receivedValue = $0 }
            .catch { receivedError = $0 }
        
        XCTAssertEqual(
            apiService.executeRequestCallsCount,
            1,
            "should call apiService once, got \(apiService.executeRequestCallsCount)"
        )
        
        XCTAssertEqual(apiService.executeRequestReceivedRequest, request)
        
        apiService.executeRequestReturnValue.fulfill(invalidJson)
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertNil(receivedValue, "shouldn't receive value")
        XCTAssertNotNil(receivedError, "should receive error")
    }
    
    func testGetWeatherWithNilData() {
        apiService.executeRequestReturnValue = Promise<Data?>.pending()
        
        var receivedValue: [City]?
        var receivedError: Error?
        subject.getWeather(for: citiesIds)
            .then { receivedValue = $0 }
            .catch { receivedError = $0 }
        
        XCTAssertEqual(
            apiService.executeRequestCallsCount,
            1,
            "should call apiService once, got \(apiService.executeRequestCallsCount)"
        )
        
        XCTAssertEqual(apiService.executeRequestReceivedRequest, request)
        
        apiService.executeRequestReturnValue.fulfill(nil)
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertNil(receivedValue, "shouldn't receive value")
        XCTAssertEqual(receivedError as NSError?, NSError.common)
    }
}

private extension CitiesWeatherServiceImplTests {
    var expectedCities: [City] {
        return [.city1, .city2]
    }
    
    var validJson: Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        return try! encoder.encode(CitiesResponse(cities: expectedCities))
    }
    
    var invalidJson: Data {
        return Data()
    }
    
    var citiesIds: [String] {
        return ["123", "42134", "asdfasd"]
    }
    
    var request: ApiServiceRequest {
        return ApiServiceRequest(
            name: "group",
            parameters: [
                "id": citiesIds.joined(separator: ","),
                "units": "metric"
            ]
        )
    }
}
