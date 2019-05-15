//
//  Created by Dmitriy Stupivtsev on 15/05/2019.
//

import XCTest
@testable import Weather

final class CitySearchTextFieldBehaviorTests: XCTestCase {
    func testSetupTextField() {
        let delegate = TextEditingDelegateMock()
        let subject = CitySearchTextFieldBehavior(delegate: delegate)
        
        let textField = UITextField()
        subject.setup(textField: textField)
        
        XCTAssertIdentical(textField.delegate, to: subject)
        
        let testText = "Test"
        textField.text = testText
        textField.sendActions(for: .editingChanged)
        XCTAssertEqual(delegate.didChangeTextCallsCount, 1)
        XCTAssertEqual(delegate.didChangeTextReceivedText, testText)
    }
}
