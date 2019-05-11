//
//  Created by Dmitriy Stupivtsev on 04/05/2019.
//

import XCTest
@testable import Promises
@testable import Weather

final class CitiesServiceImplTests: XCTestCase {
    private var subject: CitiesServiceImpl!
    private var citiesWeatherService: CitiesWeatherServiceMock!
    private var timeZoneService: TimeZoneServiceMock!
    
    override func setUp() {
        super.setUp()
        
        citiesWeatherService = .init()
        timeZoneService = .init()
        subject = CitiesServiceImpl(
            citiesWeatherService: citiesWeatherService,
            timeZoneService: timeZoneService
        )
    }
    
    func testGetWeatherSuccess() {
        citiesWeatherService.getWeatherForReturnValue = Promise<[City]>.pending()
        timeZoneService.getTimeZonesFromReturnValue = Promise<[TimeZone]>.pending()
        
        var receivedValue: [CitySource]?
        var receivedError: Error?
        subject.getCitiesWeather(for: citiesIds)
            .then { receivedValue = $0 }
            .catch { receivedError = $0 }
        
        XCTAssertEqual(citiesWeatherService.getWeatherForCallsCount, 1, "should request service")
        XCTAssertEqual(citiesWeatherService.getWeatherForReceivedCitiesIds, citiesIds, "should receive valid cities ids")
        
        let response = self.response
        let timeZones = self.timeZones
        
        citiesWeatherService.getWeatherForReturnValue.fulfill(response)
        timeZoneService.getTimeZonesFromReturnValue.fulfill(timeZones)
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(timeZoneService.getTimeZonesFromCallsCount, 1, "should request service")
        XCTAssertEqual(timeZoneService.getTimeZonesFromReceivedCoordinates, response.map { $0.coordinate }, "should receive valid cities ids")
        
        let citiesSources = createCitiesSources(with: response, timeZones: timeZones)
        XCTAssertEqual(receivedValue, citiesSources)
        XCTAssertNil(receivedError, "shouldn't receive error")
    }
    
    func testGetWeatherFailure() {
        citiesWeatherService.getWeatherForReturnValue = Promise<[City]>.pending()
        
        var receivedValue: [CitySource]?
        var receivedError: Error?
        subject.getCitiesWeather(for: citiesIds)
            .then { receivedValue = $0 }
            .catch { receivedError = $0 }
        
        XCTAssertEqual(citiesWeatherService.getWeatherForCallsCount, 1, "should request service")
        XCTAssertEqual(citiesWeatherService.getWeatherForReceivedCitiesIds, citiesIds, "should receive valid cities ids")
        
        let expectedError = NSError.error(message: "Test")
        citiesWeatherService.getWeatherForReturnValue.reject(expectedError)
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(timeZoneService.getTimeZonesFromCallsCount, 0, "should request service")
        
        XCTAssertNil(receivedValue, "shouldn't receive sources")
        XCTAssertEqual(receivedError as NSError?, expectedError)
    }
}

private extension CitiesServiceImplTests {
    var citiesIds: [String] {
        return ["123", "456"]
    }
    
    var response: [City] {
        return [.city1, .city2]
    }
    
    var timeZones: [TimeZone] {
        return [.current, TimeZone(secondsFromGMT: 123)!]
    }
    
    func createCitiesSources(with cities: [City], timeZones: [TimeZone]) -> [CitySource] {
        return zip(cities, timeZones)
            .map(CitySource.init(city:timeZone:))
    }
}
