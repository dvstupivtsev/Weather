//
//  Created by Dmitriy Stupivtsev on 25/05/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class CitiesAddStrategyTests: XCTestCase {
    private var subject: CitiesAddStrategy!
    private var store: Store<[CitySource]>!
    private var citiesService: CitiesServiceMock!
    private var router: CitiesAddRouterMock!
    
    override func setUp() {
        super.setUp()
        
        store = .init(state: [])
        citiesService = .init()
        router = .init()
        subject = CitiesAddStrategy(
            store: store,
            citiesService: citiesService,
            router: router
        )
    }

    func testSelectCityModelSuccess() {
        let expectedCitiesSources = [CitySource(city: .city1, timeZone: .current)]
        citiesService.getCitiesWeatherForReturnValue = Promise(expectedCitiesSources)
        
        let cityModel = CityModel.model1
        subject.select(cityModel: cityModel)
        XCTAssertEqual(citiesService.getCitiesWeatherForCallsCount, 1)
        XCTAssertEqual(citiesService.getCitiesWeatherForReceivedCitiesIds, [cityModel.id])
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(store.state, expectedCitiesSources)
        XCTAssertEqual(router.closeSearchCallsCount, 1)
        
        subject.select(cityModel: cityModel)
        XCTAssertEqual(citiesService.getCitiesWeatherForCallsCount, 1)
        XCTAssertEqual(store.state, expectedCitiesSources)
        XCTAssertEqual(router.closeSearchCallsCount, 2)
    }
    
    func testSelectCityModelFailure() {
        citiesService.getCitiesWeatherForReturnValue = Promise(Constants.error)
        
        let cityModel = CityModel.model1
        subject.select(cityModel: cityModel)
        XCTAssertEqual(citiesService.getCitiesWeatherForCallsCount, 1)
        XCTAssertEqual(citiesService.getCitiesWeatherForReceivedCitiesIds, [cityModel.id])
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEmpty(store.state)
        XCTAssertEqual(router.closeSearchCallsCount, 0)
    }
}
