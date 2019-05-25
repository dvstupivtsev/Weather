//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import XCTest
@testable import Weather

final class KeyboardObserverImplTests: XCTestCase {
    private var subject: KeyboardObserverImpl!
    private var notificationObserver: NotificationObserverMock!
    
    override func setUp() {
        super.setUp()
        
        notificationObserver = .init()
        subject = KeyboardObserverImpl(notificationObserver: notificationObserver)
    }
    
    func testStartObserving() {
        var notifications = [Notification.Name: Handler<Notification>]()
        notificationObserver.subscribeOnHandlerClosure = {
            notifications[$0] = $1
        }
        
        var receivedKeyboardInfo: KeyboardInfo?
        subject.startObserving { receivedKeyboardInfo = $0 }
        
        XCTAssertEqual(notificationObserver.subscribeOnHandlerCallsCount, 2)
        
        notifications[TestData.willShowNotification.name]?(TestData.willShowNotification)
        XCTAssertEqual(receivedKeyboardInfo, TestData.expectedWillShowKeyboardInfo)
        
        notifications[TestData.willHideNotification.name]?(TestData.willHideNotification)
        XCTAssertEqual(receivedKeyboardInfo, TestData.expectedWillHideKeyboardInfo)
    }
}

private extension KeyboardObserverImplTests {
    struct TestData {
        static let expectedWillShowKeyboardInfo = KeyboardInfo(verticalOffset: 10, duration: 10)
        static let willShowNotification = Notification(
            name: UIResponder.keyboardWillShowNotification,
            object: nil,
            userInfo: [
                UIResponder.keyboardFrameEndUserInfoKey: NSValue(cgRect: CGRect(x: 0, y: 0, width: 0, height: expectedWillShowKeyboardInfo.verticalOffset)),
                UIResponder.keyboardAnimationDurationUserInfoKey: NSNumber(value: expectedWillShowKeyboardInfo.duration)
            ]
        )
        
        static let expectedWillHideKeyboardInfo = KeyboardInfo(verticalOffset: 0, duration: 20)
        static let willHideNotification = Notification(
            name: UIResponder.keyboardWillHideNotification,
            object: nil,
            userInfo: [
                UIResponder.keyboardFrameEndUserInfoKey: NSValue(cgRect: CGRect(x: 0, y: 0, width: 0, height: 13)),
                UIResponder.keyboardAnimationDurationUserInfoKey: NSNumber(value: expectedWillHideKeyboardInfo.duration)
            ]
        )
    }
}
