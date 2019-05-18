//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import Foundation

// sourcery: AutoMockable
protocol NotificationObserver {
    func subscribe(on notification: Notification.Name, handler: @escaping Handler<Notification>)
}
