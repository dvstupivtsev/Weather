//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import XCTest
@testable import Weather

final class NumberFormatterTests: XCTestCase {
    func testStringFromDate() {
        XCTAssertEqual(NumberFormatter.temperature.string(from: 0), "0")
        XCTAssertEqual(NumberFormatter.temperature.string(from: 1), "1")
        XCTAssertEqual(NumberFormatter.temperature.string(from: 12), "12")
        XCTAssertEqual(NumberFormatter.temperature.string(from: 42), "42")
        
        XCTAssertEqual(NumberFormatter.temperature.string(from: -1), "-1")
        XCTAssertEqual(NumberFormatter.temperature.string(from: -990), "-990")
        
        XCTAssertEqual(NumberFormatter.temperature.string(from: -1.1234), "-1")
        XCTAssertEqual(NumberFormatter.temperature.string(from: 60.42341), "60")
        XCTAssertEqual(NumberFormatter.temperature.string(from: 60.62341), "61")
    }
}
