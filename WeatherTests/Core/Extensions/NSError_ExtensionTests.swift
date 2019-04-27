//
//  Created by Dmitriy Stupivtsev on 27/04/2019.
//

import XCTest
@testable import Weather

final class NSError_ExtensionTests: XCTestCase {
    func testCommon() {
        let error = NSError.common
        XCTAssert(error.domain == "Test", "should have Test domain")
        XCTAssert(error.code == -1, "should have code equal to -1")
        XCTAssert(error.localizedDescription == "Data loading failed", "should have valid message")
    }
    
    func testErrorWithMessage() {
        let message = "Test message"
        let error = NSError.error(message: message)
        XCTAssert(error.domain == "Test", "should have Test domain")
        XCTAssert(error.code == -1, "should have code equal to -1")
        XCTAssert(error.localizedDescription == message, "should have valid message")
    }
}
