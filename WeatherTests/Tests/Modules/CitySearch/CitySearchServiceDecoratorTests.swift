//
//  Created by Dmitriy Stupivtsev on 08/06/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class CitySearchServiceDecoratorTests: XCTestCase {
    private var subject: CitySearchServiceDecorator!
    private var citiesLoadingService: CitiesLoadingServiceMock!
    private var persistentStore: CitySearchServiceMock!
    
    override func setUp() {
        super.setUp()
        
        citiesLoadingService = .init()
        persistentStore = .init()
        subject = CitySearchServiceDecorator(
            citiesLoadingService: citiesLoadingService,
            persistentStore: persistentStore
        )
    }
    
    func testNumberOfCitiesSuccess() {
        let expected = 10
        persistentStore.numberOfCitiesReturnValue = Promise(expected)
        let result = subject.numberOfCities()
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(persistentStore.numberOfCitiesCallsCount, 1)
        XCTAssertEqual(result.value, expected)
        XCTAssertNil(result.error)
    }
    
    func testNumberOfCitiesFailure() {
        let expected = Constants.error
        persistentStore.numberOfCitiesReturnValue = Promise(expected)
        let result = subject.numberOfCities()
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(persistentStore.numberOfCitiesCallsCount, 1)
        XCTAssertIdentical(result.error, to: expected)
        XCTAssertNil(result.value)
    }
    
    func testInsertCitiesModelsSuccess() {
        let models = [CityModel.model1]
        persistentStore.insertCitiesModelsReturnValue = Promise(())
        let result = subject.insert(citiesModels: models)
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(persistentStore.insertCitiesModelsCallsCount, 1)
        XCTAssertEqual(persistentStore.insertCitiesModelsReceivedCitiesModels, models)
        XCTAssertNotNil(result.value)
        XCTAssertNil(result.error)
    }
    
    func testInsertCitiesModelsFailure() {
        let expected = Constants.error
        let models = [CityModel.model1]
        persistentStore.insertCitiesModelsReturnValue = Promise(expected)
        let result = subject.insert(citiesModels: models)
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(persistentStore.insertCitiesModelsCallsCount, 1)
        XCTAssertEqual(persistentStore.insertCitiesModelsReceivedCitiesModels, models)
        XCTAssertIdentical(result.error, to: expected)
        XCTAssertNil(result.value)
    }
    
    func testGetCitiesWithZeroLimit() {
        let result = subject.getCities(filteredWith: "123", limit: 0)
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEmpty(result.value)
        XCTAssertNil(result.error)
    }
    
    func testGetCitiesWithEmptyCityName() {
        let result = subject.getCities(filteredWith: "", limit: 100)
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEmpty(result.value)
        XCTAssertNil(result.error)
    }
    
    func testGetCitiesSuccess() {
        let expected = [CityModel.model1, .model2]
        citiesLoadingService.loadCitiesReturnValue = Promise(())
        persistentStore.getCitiesFilteredWithLimitReturnValue = Promise(expected)
        let result = subject.getCities(filteredWith: "123", limit: 100)
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(result.value, expected)
        XCTAssertNil(result.error)
    }
    
    func testGetCitiesLoadingFailure() {
        let expected = Constants.error
        citiesLoadingService.loadCitiesReturnValue = Promise(expected)
        let result = subject.getCities(filteredWith: "123", limit: 100)
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertNil(result.value)
        XCTAssertIdentical(result.error, to: expected)
    }
    
    func testGetCitiesStoreFailure() {
        let expected = Constants.error
        citiesLoadingService.loadCitiesReturnValue = Promise(())
        persistentStore.getCitiesFilteredWithLimitReturnValue = Promise(expected)
        let result = subject.getCities(filteredWith: "123", limit: 100)
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertNil(result.value)
        XCTAssertIdentical(result.error, to: expected)
    }
}
