//
//  Created by Dmitriy Stupivtsev on 02/06/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class PersistentCitiesLoadingServiceTests: XCTestCase {
    private var subject: PersistentCitiesLoadingService!
    private var service: CitiesParsingServiceMock!
    private var persistentStore: CitiesPersistentStoreMock!
    
    override func setUp() {
        super.setUp()
        
        service = .init()
        persistentStore = .init()
        subject = PersistentCitiesLoadingService(
            service: service,
            persistentStore: persistentStore
        )
    }

    func testLoadCitiesSuccessWithZeroCount() {
        persistentStore.numberOfCitiesReturnValue = Promise(0)
        let result = subject.loadCities()
        
        XCTAssertEqual(persistentStore.numberOfCitiesCallsCount, 1)
        
        let models = [CityModel.model1, .model2]
        service.getCitiesReturnValue = Promise(models)
        
        persistentStore.insertCitiesModelsReturnValue = Promise(())
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(service.getCitiesCallsCount, 1)
        
        XCTAssertEqual(persistentStore.insertCitiesModelsCallsCount, 1)
        XCTAssertEqual(persistentStore.insertCitiesModelsReceivedCitiesModels, models)
        
        XCTAssertNotNil(result.value)
        XCTAssertNil(result.error)
    }
    
    func testLoadCitiesSuccessWithSomeEntities() {
        persistentStore.numberOfCitiesReturnValue = Promise(1)
        let result = subject.loadCities()
        
        XCTAssertEqual(persistentStore.numberOfCitiesCallsCount, 1)
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(service.getCitiesCallsCount, 0)
        XCTAssertEqual(persistentStore.insertCitiesModelsCallsCount, 0)
        XCTAssertNotNil(result.value)
        XCTAssertNil(result.error)
    }
    
    func testLoadCitiesPersistentStoreFailure() {
        let expectedError = Constants.error
        persistentStore.numberOfCitiesReturnValue = Promise(expectedError)
        let result = subject.loadCities()
        
        XCTAssertEqual(persistentStore.numberOfCitiesCallsCount, 1)
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(service.getCitiesCallsCount, 0)
        XCTAssertEqual(persistentStore.insertCitiesModelsCallsCount, 0)
        XCTAssertNil(result.value)
        XCTAssertIdentical(result.error, to: expectedError)
    }
    
    func testLoadCitiesServiceFailure() {
        persistentStore.numberOfCitiesReturnValue = Promise(0)
        let result = subject.loadCities()
        
        XCTAssertEqual(persistentStore.numberOfCitiesCallsCount, 1)
        
        let expectedError = Constants.error
        service.getCitiesReturnValue = Promise(expectedError)
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(service.getCitiesCallsCount, 1)
        
        XCTAssertEqual(persistentStore.insertCitiesModelsCallsCount, 0)
        XCTAssertNil(result.value)
        XCTAssertIdentical(result.error, to: expectedError)
    }
}
