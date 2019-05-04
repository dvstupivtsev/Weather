//
//  Created by Dmitriy Stupivtsev on 03/05/2019.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255,
            blue: CGFloat(hex & 0x0000FF) / 255,
            alpha: 1
        )
    }
}
