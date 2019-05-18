//
//  Created by Dmitriy Stupivtsev on 17/05/2019.
//

import XCTest
@testable import Weather

final class CancelledTests: XCTestCase {
    func testIsCancelled() {
        let subject = Cancelled()
        XCTAssertTrue(subject.isCancelled)
    }
}
