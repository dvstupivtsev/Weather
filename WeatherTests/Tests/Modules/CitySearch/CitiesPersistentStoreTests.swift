//
//  Created by Dmitriy Stupivtsev on 08/06/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class CitiesPersistentStoreTests: XCTestCase {
    private var subject: CitiesPersistentStore!
    private var persistentStore: PersistentStoreMock!
    private let entityName = "CityEntity"
    
    override func setUp() {
        super.setUp()
        
        persistentStore = .init()
        subject = CitiesPersistentStore(persistentStore: persistentStore)
    }
    
//    func testNumberOfCities() {
//        let result = subject.numberOfCities()
//
//        XCTAssert(waitForPromises(timeout: 1))
//
//        XCTAssertEqual(persistentStore.countForCompletionCallsCount, 1)
//        XCTAssertEqual(persistentStore.countForCompletionReceivedArgs?.entityName, entityName)
//
//        let expected = 10
//        persistentStore.countForCompletionReceivedArgs?.completion(expected)
//
//        XCTAssertEqual(result.value, expected)
//        XCTAssertNil(result.error)
//    }
    
//    func testInsertCitiesModels() {
//        let models = [CityModel.model1]
//        _ = subject.insert(citiesModels: models)
//        XCTAssert(waitForPromises(timeout: 1))
//
//        XCTAssertEqual(persistentStore.insertForCompletionCallsCount, 1)
//
//        let args = persistentStore.insertForCompletionReceivedArgs
//        XCTAssertEqual(args?.entityName, entityName)
//
//        XCTAssertEqual(args?.keyValuePairsArray.count, 1)
//        let pairs = args?.keyValuePairsArray.first
//        XCTAssertEqual(pairs?["id"] as? Int, 1)
//        XCTAssertEqual(pairs?["name"] as? String, "Name1")
//        XCTAssertEqual(pairs?["country"] as? String, "Country1")
//    }
//
//    func testGetCities() {
//        let result = subject.getCities(filteredWith: "123", limit: 10)
//        
//        XCTAssert(waitForPromises(timeout: 1))
//        
//        let args = persistentStore.keyValuePairsForPredicateLimitCompletionReceivedArgs
//        XCTAssertEqual(args?.entityName, entityName)
//        XCTAssertEqual(args?.predicate?.predicateFormat, "name CONTAINS[cd] \"123\"")
//        XCTAssertEqual(args?.limit, 10)
//        
//        args?.completion(
//            [
//                [
//                    "id": 1,
//                    "name": "Name1",
//                    "country": "Country1",
//                ]
//            ]
//        )
//        
//        XCTAssertEqual(result.value, [CityModel.model1])
//        XCTAssertNil(result.error)
//    }
}
