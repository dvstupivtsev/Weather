//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import XCTest
@testable import Weather

final class UIEdgeInsets_ExtensionTests: XCTestCase {
    func testInitAll() {
        expectAllEdgesEqual(to: 0)
        expectAllEdgesEqual(to: 1)
        expectAllEdgesEqual(to: 2)
        expectAllEdgesEqual(to: 12)
        expectAllEdgesEqual(to: 65)
        expectAllEdgesEqual(to: -1)
        expectAllEdgesEqual(to: -2)
        expectAllEdgesEqual(to: -12)
        expectAllEdgesEqual(to: -65)
        expectAllEdgesEqual(to: 0.34263)
        expectAllEdgesEqual(to: 1.34263)
        expectAllEdgesEqual(to: 2.34263)
        expectAllEdgesEqual(to: 12.34263)
        expectAllEdgesEqual(to: 65.34263)
        expectAllEdgesEqual(to: -1.34263)
        expectAllEdgesEqual(to: -2.34263)
        expectAllEdgesEqual(to: -12.34263)
        expectAllEdgesEqual(to: -65.34263)
    }
    
    func expectAllEdgesEqual(to value: CGFloat) {
        let insets = UIEdgeInsets(all: value)
        XCTAssertEqual(insets.top, value, "expect top to be \(value), got \(insets.top)")
        XCTAssertEqual(insets.bottom, value, "expect bottom to be \(value), got \(insets.bottom)")
        XCTAssertEqual(insets.left, value, "expect left to be \(value), got \(insets.left)")
        XCTAssertEqual(insets.right, value, "expect right to be \(value), got \(insets.right)")
    }
}
