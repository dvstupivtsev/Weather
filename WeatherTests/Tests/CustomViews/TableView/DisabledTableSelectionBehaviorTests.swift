//
//  Created by Dmitriy Stupivtsev on 13/05/2019.
//

import XCTest
@testable import Weather

final class DisabledTableSelectionBehaviorTests: XCTestCase {
    func testShouldSelect() {
        let subject = DisabledCollectionSelectionBehavior()
        
        XCTAssertFalse(subject.shouldSelect(at: IndexPath(row: 0, section: 0)))
        XCTAssertFalse(subject.shouldSelect(at: IndexPath(row: 1, section: 0)))
        XCTAssertFalse(subject.shouldSelect(at: IndexPath(row: 0, section: 1)))
        XCTAssertFalse(subject.shouldSelect(at: IndexPath(row: 1234, section: 5)))
        XCTAssertFalse(subject.shouldSelect(at: IndexPath(row: 1, section: 21)))
    }
}
