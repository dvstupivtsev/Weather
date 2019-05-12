//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension UIView: ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
