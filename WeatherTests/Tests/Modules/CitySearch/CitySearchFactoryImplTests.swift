//
//  Created by Dmitriy Stupivtsev on 15/05/2019.
//

import XCTest
@testable import Weather

final class CitySearchFactoryImplTests: XCTestCase {
    func testCreate() {
        let subject = CitySearchFactoryImpl()
        
        let received = subject.create(
            selectStrategy: CitySearchSelectStrategyMock(),
            persistentStore: CitySearchServiceMock()
        )
        XCTAssert(received, isKindOf: CitySearchViewController.self)
    }
}
