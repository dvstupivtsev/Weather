//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import UIKit

// sourcery: AutoMockable
protocol Transitionable {
    func present(controller: UIViewController, animated: Bool, completion: Action?)
    func dismiss(animated: Bool, completion: Action?)
    
    func push(controller: UIViewController, animated: Bool)
    func pop(animated: Bool)
}
