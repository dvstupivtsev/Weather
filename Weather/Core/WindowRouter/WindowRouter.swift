//
//  Created by Dmitriy Stupivtsev on 05/05/2019.
//

import UIKit

final class WindowRouter {
    private let controllerFactory: ControllerFactory
    
    init(controllerFactory: ControllerFactory) {
        self.controllerFactory = controllerFactory
    }
    
    func setRoot(window: UIWindow) {
        window.rootViewController = controllerFactory.create()
        window.makeKeyAndVisible()
    }
}
