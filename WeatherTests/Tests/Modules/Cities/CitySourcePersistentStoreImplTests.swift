//
//  Created by Dmitriy Stupivtsev on 07/06/2019.
//

import XCTest
@testable import Weather
@testable import Promises

class CitySourcePersistentStoreImplTests: XCTestCase {
    private var subject: CitySourcePersistentStoreImpl!
    private var persistentStore: PersistentStoreMock!
    
    private let entityName = "CitySourceEntity"
    
    override func setUp() {
        super.setUp()
        
        persistentStore = .init()
        subject = CitySourcePersistentStoreImpl(persistentStore: persistentStore)
    }
    
    func testInsertCities() {
        _ = subject.insert(cities: [CitySource(city: .city1, timeZone: TimeZone(secondsFromGMT: 100)!)])
        
        persistentStore.insertForCompletionReceivedArgs?.completion()
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(persistentStore.insertForCompletionCallsCount, 1)
        XCTAssertEqual(persistentStore.insertForCompletionReceivedArgs?.entityName, entityName)
        
        let receivedPairsArray = persistentStore.insertForCompletionReceivedArgs?.keyValuePairsArray
        XCTAssertEqual(receivedPairsArray?.count, 1)
        
        let pairs = receivedPairsArray?.first
        XCTAssertEqual(pairs?["id"] as? Int, 1)
        XCTAssertEqual(pairs?["name"] as? String, "Name1")
        XCTAssertEqual(pairs?["date"] as? Date, Constants.date)
        XCTAssertEqual(pairs?["coordinateLat"] as? Double, 1)
        XCTAssertEqual(pairs?["coordinateLon"] as? Double, 2)
        XCTAssertEqual(pairs?["weatherDescription"] as? String, "Desc1")
        XCTAssertEqual(pairs?["weatherIcon"] as? String, "Icon1")
        XCTAssertEqual(pairs?["mainTemp"] as? Double, 1)
        XCTAssertEqual(pairs?["timeZoneSeconds"] as? Int, 100)
    }
    
    func testCities() {
        let result = subject.cities()
        
        let args = persistentStore.keyValuePairsForPredicateLimitCompletionReceivedArgs
        XCTAssertEqual(args?.entityName, entityName)
        XCTAssertEqual(args?.limit, 100)
        XCTAssertNil(args?.predicate)
        
        let pairsArray = [
            [
                "id": 1,
                "name": "Name1",
                "date": Constants.date,
                "coordinateLat": 1,
                "coordinateLon": 2,
                "weatherDescription": "Desc1",
                "weatherIcon": "Icon1",
                "mainTemp": 1,
                "timeZoneSeconds": 100,
            ]
        ]
        args?.completion(pairsArray)
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(result.value, [CitySource(city: .city1, timeZone: TimeZone(secondsFromGMT: 100)!)])
    }
}
