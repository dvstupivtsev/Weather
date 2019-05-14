//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import UIKit

struct Color {
    static var clear: UIColor {
        return .clear
    }
    
    static var white: UIColor {
        return .white
    }
    
    static var white70: UIColor {
        return white.withAlphaComponent(0.7)
    }
    
    static var black: UIColor {
        return .black
    }
    
    static var black50: UIColor {
        return black.withAlphaComponent(0.5)
    }
    
    static var black10: UIColor {
        return black.withAlphaComponent(0.1)
    }
    
    static var bg1: UIColor {
        return UIColor(hex: 0x197DC8)
    }
    
    static var bg2: UIColor {
        return UIColor(hex: 0x328CC8)
    }
    
    static var bg3: UIColor {
        return UIColor(hex: 0x4B96C8)
    }
    
    static var bg4: UIColor {
        return UIColor(hex: 0x64A0C8)
    }
    
    static var bg5: UIColor {
        return UIColor(hex: 0x7DAAC8)
    }
}
