//
//  Created by Dmitriy Stupivtsev on 27/04/2019.
//

import XCTest
@testable import Weather

final class NSError_ExtensionTests: XCTestCase {
    func testCommon() {
        let error = NSError.common
        XCTAssertEqual(error.domain, "Test", "should have Test domain")
        XCTAssertEqual(error.code, -1, "should have code equal to -1")
        XCTAssertEqual(error.localizedDescription, "Data loading failed", "should have valid message")
    }
    
    func testErrorWithMessage() {
        let message = "Test message"
        let error = NSError.error(message: message)
        XCTAssertEqual(error.domain, "Test", "should have Test domain")
        XCTAssertEqual(error.code, -1, "should have code equal to -1")
        XCTAssertEqual(error.localizedDescription, message, "should have valid message")
    }
}
