//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    func insertFirst(subview: UIView) {
        insertSubview(subview, at: 0)
    }
    
    func roundCorners(_ corners: UIRectCorner = .allCorners, radius: CGFloat) {
        layer.mask = setup(CAShapeLayer()) {
            $0.frame = bounds
            $0.path = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(edge: radius)
            ).cgPath
        }
    }
}
