//
//  Created by Dmitriy Stupivtsev on 27/04/2019.
//

import XCTest
@testable import Promises
@testable import Weather

final class CitiesViewModelImplTests: XCTestCase {
    private var citiesService: CitiesServiceMock!
    private var subject: CitiesViewModelImpl!
    
    override func setUp() {
        super.setUp()
        
        citiesService = CitiesServiceMock()
        subject = CitiesViewModelImpl(citiesService: citiesService)
    }
    
    func testGetDataSuccess() {
        citiesService.getWeatherForReturnValue = Promise<CitiesResponse>.pending()
        
        var receivedValue: CitiesViewSource?
        var receivedError: Error?
        subject.getData()
            .then { receivedValue = $0 }
            .catch { receivedError = $0 }
        
        XCTAssert(citiesService.getWeatherForCallsCount == 1, "should request service")
        XCTAssert(citiesService.getWeatherForReceivedCitiesIds == citiesIds, "should receive valid cities ids")
        
        citiesService.getWeatherForReturnValue.fulfill(CitiesResponse(data: []))
        XCTAssert(waitForPromises(timeout: 1))
        
        let expectedViewSource = self.expectedViewSource
        XCTAssert(receivedValue?.title == expectedViewSource.title, "should receive valid title")
        XCTAssert(receivedValue?.cellProviderConvertibles.count == expectedViewSource.cellProviderConvertibles.count, "should receive valid cells providers")
        XCTAssert(receivedError == nil, "shouldn't receive error")
    }
    
    func testGetDataFailure() {
        citiesService.getWeatherForReturnValue = Promise<CitiesResponse>.pending()
        
        var receivedValue: CitiesViewSource?
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
    
    var expectedViewSource: CitiesViewSource {
        return CitiesViewSource(
            title: MeasurementFormatter.celsius.string(from: 0),
            cellProviderConvertibles: []
        )
    }
}
