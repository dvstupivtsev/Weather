//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview(_:))
    }
}
