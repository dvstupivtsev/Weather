//
//  Created by Dmitriy Stupivtsev on 25/05/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class CitiesAddStrategyTests: XCTestCase {
    private var subject: CitiesAddStrategy!
    private var store: Store<[CitySource]>!
    private var citySourceService: CitySourceServiceMock!
    private var citiesService: CitiesServiceMock!
    private var router: CitiesAddRouterMock!
    private var loadingPresentable: LoadingPresentableMock!
    
    override func setUp() {
        super.setUp()
        
        store = .init(state: [])
        citySourceService = .init()
        citiesService = .init()
        router = .init()
        loadingPresentable = .init()
        subject = CitiesAddStrategy(
            store: store,
            citySourceService: citySourceService,
            citiesService: citiesService,
            router: router,
            loadingPresentable: loadingPresentable
        )
    }

    func testSelectCityModelSuccess() {
        citySourceService.insertCitiesReturnValue = Promise(())
        
        let expectedCitiesSources = [CitySource(city: .city1, timeZone: .current)]
        citiesService.getCitiesWeatherForReturnValue = Promise(expectedCitiesSources)
        
        let cityModel = CityModel.model1
        subject.select(cityModel: cityModel)
        XCTAssertEqual(loadingPresentable.showLoadingCallsCount, 1)
        XCTAssertEqual(citiesService.getCitiesWeatherForCallsCount, 1)
        XCTAssertEqual(citiesService.getCitiesWeatherForReceivedCitiesIds, [cityModel.id])
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(store.state, expectedCitiesSources)
        XCTAssertEqual(loadingPresentable.hideLoadingCallsCount, 1)
        XCTAssertEqual(router.closeSearchCallsCount, 1)
        
        XCTAssertEqual(citySourceService.insertCitiesCallsCount, 1)
        XCTAssertEqual(citySourceService.insertCitiesReceivedCities, expectedCitiesSources)
        
        subject.select(cityModel: cityModel)
        XCTAssertEqual(citiesService.getCitiesWeatherForCallsCount, 1)
        XCTAssertEqual(store.state, expectedCitiesSources)
        XCTAssertEqual(router.closeSearchCallsCount, 2)
    }
    
    func testSelectCityModelFailure() {
        let expected = Constants.error
        citiesService.getCitiesWeatherForReturnValue = Promise(expected)
        
        let cityModel = CityModel.model1
        subject.select(cityModel: cityModel)
        XCTAssertEqual(loadingPresentable.showLoadingCallsCount, 1)
        XCTAssertEqual(citiesService.getCitiesWeatherForCallsCount, 1)
        XCTAssertEqual(citiesService.getCitiesWeatherForReceivedCitiesIds, [cityModel.id])
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEmpty(store.state)
        XCTAssertEqual(router.closeSearchCallsCount, 0)
        
        XCTAssertEqual(loadingPresentable.hideLoadingCallsCount, 1)
        XCTAssertEqual(router.presentErrorCallsCount, 1)
        XCTAssertIdentical(router.presentErrorReceivedError, to: expected)
    }
}
