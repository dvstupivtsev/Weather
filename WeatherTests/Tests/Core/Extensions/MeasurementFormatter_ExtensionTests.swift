//
//  Created by Dmitriy Stupivtsev on 28/04/2019.
//

import XCTest
@testable import Weather

final class MeasurementFormatter_ExtensionTests: XCTestCase {
    func testCelsiusFormatter() {
        let subject = MeasurementFormatter.celsius
        
        compare(expected: "0°", received: subject.string(from: 0))
        compare(expected: "1°", received: subject.string(from: 1))
        compare(expected: "12°", received: subject.string(from: 12))
        compare(expected: "42°", received: subject.string(from: 42))
        
        compare(expected: "-1°", received: subject.string(from: -1))
        compare(expected: "-990°", received: subject.string(from: -990))
        
        compare(expected: "-1°", received: subject.string(from: -1.1234))
        compare(expected: "60°", received: subject.string(from: 60.42341))
        compare(expected: "61°", received: subject.string(from: 60.62341))
    }
}
