//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import XCTest
@testable import Weather

final class DateFormatterTests: XCTestCase {
    func testStringFromDate() {
        let date = Date(timeIntervalSince1970: 1557569160)
        XCTAssertEqual(DateFormatter.hh_mm_a.string(from: date), "10:06 AM")
        XCTAssertEqual(DateFormatter.MM_dd_yyyy_hh_mm_a.string(from: date), "05/11/2019 10:06 AM")
        XCTAssertEqual(DateFormatter.EEEE_MMM_dd.string(from: date), "Saturday, May 11")
        XCTAssertEqual(DateFormatter.EEEE.string(from: date), "Saturday")
        XCTAssertEqual(DateFormatter.MMM_dd.string(from: date), "May 11")
    }
}
