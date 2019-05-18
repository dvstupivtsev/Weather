//
//  Created by Dmitriy Stupivtsev on 16/05/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class CitySearchServiceImplTests: XCTestCase {
    private var subject: CitySearchServiceImpl!
    private var citiesLoadingService: CitiesLoadingServiceMock!
    
    override func setUp() {
        super.setUp()
        
        citiesLoadingService = .init()
        subject = CitySearchServiceImpl(citiesLoadingService: citiesLoadingService)
    }
    
    func testGetCitiesSuccess() {
        let notFilteredCities = TestData.cities
        citiesLoadingService.getCitiesReturnValue = Promise(notFilteredCities)
        
        let result = subject.getCities(for: TestData.filterString, limit: 3)
        
        XCTAssertEqual(citiesLoadingService.getCitiesCallsCount, 1)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(result.value, TestData.expectedCities)
        XCTAssertNil(result.error)
    }
    
    func testGetCitiesFailure() {
        let expectedError = Constants.error
        citiesLoadingService.getCitiesReturnValue = Promise(expectedError)
        
        let result = subject.getCities(for: "1234", limit: 3)
        
        XCTAssertEqual(citiesLoadingService.getCitiesCallsCount, 1)
        
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
        
        static let cities: [CityModel] = {
            var cities = [
                CityModel(id: 1, name: "1623TEST", country: "TEstTest"),
                CityModel(id: 2, name: "TEstT", country: "Imaginationland123"),
                CityModel(id: 3, name: "City", country: "Test")
            ]
            
            cities.append(contentsOf: expectedCities)
            
            return cities
        }()
    }
}
