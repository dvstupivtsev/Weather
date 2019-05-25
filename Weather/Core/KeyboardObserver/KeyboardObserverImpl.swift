//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import UIKit
import Weakify

final class KeyboardObserverImpl: KeyboardObserver {
    private let notificationObserver: NotificationObserver
    
    private var onChange: Handler<KeyboardInfo>?
    
    init(notificationObserver: NotificationObserver) {
        self.notificationObserver = notificationObserver
    }
    
    func startObserving(handler: @escaping Handler<KeyboardInfo>) {
        onChange = handler
        
        notificationObserver.subscribe(
            on: UIResponder.keyboardWillShowNotification,
            handler: weakify(self, type(of: self).handleKeyboardWillShow(notification:))
        )
        
        notificationObserver.subscribe(
            on: UIResponder.keyboardWillHideNotification,
            handler: weakify(self, type(of: self).handleKeyboardWillHide(notification:))
        )
    }
    
    private func handleKeyboardWillShow(notification: Notification) {
        let info = notification.userInfo
        let frameEnd = (info?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        
        let verticalOffset = frameEnd.height
        let value = info?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        
        let duration = value.map { $0.doubleValue } ?? 0
        
        onChange?(KeyboardInfo(verticalOffset: verticalOffset, duration: duration))
    }
    
    private func handleKeyboardWillHide(notification: Notification) {
        let value = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        let duration = value.map { $0.doubleValue } ?? 0
        
        onChange?(KeyboardInfo(verticalOffset: 0, duration: duration))
    }
}
