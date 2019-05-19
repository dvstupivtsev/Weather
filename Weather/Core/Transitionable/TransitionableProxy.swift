//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import UIKit

// TODO: Tests
final class TransitionableProxy: Transitionable {
    weak var wrapped: UIViewController?
    
    func present(controller: UIViewController, animated: Bool, completion: Action?) {
        wrapped?.present(controller, animated: animated, completion: completion)
    }
    
    func dismiss(animated: Bool, completion: Action?) {
        wrapped?.dismiss(animated: animated, completion: completion)
    }
    
    func push(controller: UIViewController, animated: Bool) {
        wrapped?.navigationController?.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool) {
        wrapped?.navigationController?.popViewController(animated: animated)
    }
}
