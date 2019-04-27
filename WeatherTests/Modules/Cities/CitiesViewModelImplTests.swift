//
//  Created by Dmitriy Stupivtsev on 27/04/2019.
//

import XCTest
import Promises
@testable import Weather

class CitiesViewModelImplTests: XCTestCase {
    private var citiesService: CitiesServiceMock!
    private var subject: CitiesViewModelImpl!
    
    override func setUp() {
        super.setUp()
        
        citiesService = CitiesServiceMock()
        subject = CitiesViewModelImpl(citiesService: citiesService)
    }
    
    func testGetDataSuccess() {
        citiesService.getWeatherForReturnValue = Promise<CitiesResponse>.pending()
        
        var receivedValue: Void?
        var receivedError: Error?
        subject.getData()
            .then { receivedValue = $0 }
            .catch { receivedError = $0 }
        
        XCTAssert(citiesService.getWeatherForCallsCount == 1, "should request service")
        XCTAssert(citiesService.getWeatherForReceivedCitiesIds == citiesIds, "should receive valid cities ids")
        
        citiesService.getWeatherForReturnValue.fulfill(CitiesResponse(data: []))
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssert(receivedValue != nil, "should receive data")
        XCTAssert(receivedError == nil, "shouldn't receive error")
    }
    
    func testGetDataFailure() {
        citiesService.getWeatherForReturnValue = Promise<CitiesResponse>.pending()
        
        var receivedValue: Void?
        var receivedError: Error?
        subject.getData()
            .then { receivedValue = $0 }
            .catch { receivedError = $0 }
        
        XCTAssert(citiesService.getWeatherForCallsCount == 1, "should request service")
        XCTAssert(citiesService.getWeatherForReceivedCitiesIds == citiesIds, "should receive valid cities ids")
        
        let expectedError = NSError.error(message: "Test")
        citiesService.getWeatherForReturnValue.reject(expectedError)
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssert(receivedValue == nil, "shouldn't receive data")
        XCTAssert(receivedError as NSError? == expectedError, "should receive error")
    }
}

private extension CitiesViewModelImplTests {
    var citiesIds: [String] {
        return [
            "2950159",
            "2968815",
            "2643743",
            "3128760",
            "4699066",
            "98182",
            "3518326",
            "2664454",
            "1850147",
            "1819729",
        ]
    }
}
