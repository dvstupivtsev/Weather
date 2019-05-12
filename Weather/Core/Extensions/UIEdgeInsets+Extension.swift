//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import UIKit

extension UIEdgeInsets {
    init(all edge: CGFloat) {
        self.init(top: edge, left: edge, bottom: edge, right: edge)
    }
    
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
