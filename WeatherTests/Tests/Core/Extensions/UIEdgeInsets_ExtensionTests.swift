//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import XCTest
@testable import Weather

final class UIEdgeInsets_ExtensionTests: XCTestCase {
    private let testValues: [CGFloat] = [0, 1, 2, 12, 65, -1, -2, -12, -65, 0.34263, 1.34263, 2.34263, 12.34263, 65.34263, -1.34263, -2.34263, -12.34263, -65.34263]
    
    func testInitAll() {
        testValues.forEach {
            let insets = UIEdgeInsets(all: $0)
            XCTAssertEqual(insets.left, $0, "expect left to be \($0), got \(insets.left)")
            XCTAssertEqual(insets.right, $0, "expect right to be \($0), got \(insets.right)")
            XCTAssertEqual(insets.top, $0, "expect top to be \($0), got \(insets.top)")
            XCTAssertEqual(insets.bottom, $0, "expect bottom to be \($0), got \(insets.bottom)")
        }
    }
    
    func testInitHorizontalVertical() {
        let horizontalValues = testValues
        let verticalValues = testValues.reversed()
        zip(horizontalValues, verticalValues).forEach {
            let insets = UIEdgeInsets(horizontal: $0, vertical: $1)
            XCTAssertEqual(insets.left, $0, "expect left to be \($0), got \(insets.left)")
            XCTAssertEqual(insets.right, $0, "expect right to be \($0), got \(insets.right)")
            XCTAssertEqual(insets.top, $1, "expect top to be \($1), got \(insets.top)")
            XCTAssertEqual(insets.bottom, $1, "expect bottom to be \($1), got \(insets.bottom)")
        }
    }
}
