//
//  Created by Dmitriy Stupivtsev on 05/05/2019.
//

import UIKit

final class WindowRouter {
    func setRoot(window: UIWindow) {
        window.rootViewController = PagesViewController(controllers: [CitiesFactory().create()])
        window.makeKeyAndVisible()
    }
}
