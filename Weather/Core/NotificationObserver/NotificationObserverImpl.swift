//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import Foundation

final class NotificationObserverImpl: NotificationObserver {
    private let notificationCenter: NotificationCenter
    
    private lazy var observers = [NSObjectProtocol]()
    
    deinit {
        observers.forEach(notificationCenter.removeObserver)
    }
    
    init(notificationCenter: NotificationCenter) {
        self.notificationCenter = notificationCenter
    }
    
    func subscribe(on notification: Notification.Name, handler: @escaping Handler<Notification>) {
        let observer = notificationCenter.addObserver(
            forName: notification,
            object: nil,
            queue: nil,
            using: handler
        )
        
        observers.append(observer)
    }
}
