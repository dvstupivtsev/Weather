//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import UIKit

// sourcery: AutoMockable
protocol ControllerFactory {
    func create() -> UIViewController
}
