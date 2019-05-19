//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import XCTest
@testable import Weather

final class AddCitiesSourcesActionTests: XCTestCase {
    func testModify() {
        let subject = AddCitiesSourcesAction(citisSources: TestData.modifier)
        XCTAssertEqual(subject.modify(state: TestData.validInitialState), TestData.expectedState)
    }
    
    func test_modify() {
        let subject = AddCitiesSourcesAction(citisSources: TestData.modifier)
        XCTAssertEqual(subject._modify(state: TestData.validInitialState) as? [CitySource], TestData.expectedState)
        XCTAssertEqual(subject._modify(state: TestData.invalidInitialState) as? String, TestData.invalidInitialState)
    }
}

private extension AddCitiesSourcesActionTests {
    struct TestData {
        static let validInitialState = [CitySource(city: .city1, timeZone: .current)]
        static let invalidInitialState = "123"
        static let modifier: [CitySource] = [CitySource(city: .city2, timeZone: .current)]
        static let expectedState = [
            CitySource(city: .city1, timeZone: .current),
            CitySource(city: .city2, timeZone: .current)
        ]
    }
}
