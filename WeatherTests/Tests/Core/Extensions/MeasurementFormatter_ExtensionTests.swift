//
//  Created by Dmitriy Stupivtsev on 28/04/2019.
//

import XCTest
@testable import Weather

final class MeasurementFormatter_ExtensionTests: XCTestCase {
    func testCelsiusFormatter() {
        let subject = MeasurementFormatter.celsius
        
        XCTAssertEqual(subject.string(from: 0), "0°")
        XCTAssertEqual(subject.string(from: 1), "1°")
        XCTAssertEqual(subject.string(from: 12), "12°")
        XCTAssertEqual(subject.string(from: 42), "42°")
        
        XCTAssertEqual(subject.string(from: -1), "-1°")
        XCTAssertEqual(subject.string(from: -990), "-990°")
        
        XCTAssertEqual(subject.string(from: -1.1234), "-1°")
        XCTAssertEqual(subject.string(from: 60.42341), "60°")
        XCTAssertEqual(subject.string(from: 60.62341), "61°")
    }
}
