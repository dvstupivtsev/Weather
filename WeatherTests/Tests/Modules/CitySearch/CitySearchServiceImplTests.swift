//
//  Created by Dmitriy Stupivtsev on 16/05/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class CitySearchServiceImplTests: XCTestCase {
    private var subject: CitySearchServiceImpl!
    private var citiesLoadingService: CitiesLoadingServiceMock!
    private var persistentStore: CitiesPersistentStoreMock!
    
    override func setUp() {
        super.setUp()
        
        citiesLoadingService = .init()
        persistentStore = .init()
        subject = CitySearchServiceImpl(
            citiesLoadingService: citiesLoadingService,
            persistentStore: persistentStore
        )
    }
    
    func testGetCitiesSuccess() {
        citiesLoadingService.loadCitiesReturnValue = Promise(())
        
        let result = subject.getCities(for: TestData.filterString, limit: 3)
        
        XCTAssertEqual(citiesLoadingService.loadCitiesCallsCount, 1)
        
        let expectedModels = TestData.expectedCities
        persistentStore.citiesFilteredWithLimitReturnValue = Promise(expectedModels)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(persistentStore.citiesFilteredWithLimitCallsCount, 1)
        XCTAssertEqual(result.value, TestData.expectedCities)
        XCTAssertNil(result.error)
    }
    
    func testGetCitiesSuccessWithNullLimit() {
        citiesLoadingService.loadCitiesReturnValue = Promise(())
        
        let result = subject.getCities(for: TestData.filterString, limit: 0)
        
        XCTAssertEqual(citiesLoadingService.loadCitiesCallsCount, 0)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEmpty(result.value)
        XCTAssertNil(result.error)
    }
    
    func testGetCitiesSuccessWithEmptyFilterString() {
        citiesLoadingService.loadCitiesReturnValue = Promise(())
        
        let result = subject.getCities(for: "", limit: 2)
        
        XCTAssertEqual(citiesLoadingService.loadCitiesCallsCount, 0)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEmpty(result.value)
        XCTAssertNil(result.error)
    }
    
    func testGetCitiesFailure() {
        let expectedError = Constants.error
        citiesLoadingService.loadCitiesReturnValue = Promise(expectedError)
        
        let result = subject.getCities(for: "1234", limit: 3)
        
        XCTAssertEqual(citiesLoadingService.loadCitiesCallsCount, 1)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertIdentical(result.error, to: expectedError)
        XCTAssertNil(result.value)
    }
}

private extension CitySearchServiceImplTests {
    struct TestData {
        static let filterString = "Imaginationland"
        
        static let expectedCities: [CityModel] = [
            CityModel(id: 4, name: "Imaginationland123", country: "Test"),
            CityModel(id: 5, name: "Imaginationland456", country: "Test"),
        ]
    }
}
