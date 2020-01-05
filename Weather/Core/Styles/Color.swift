//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import UIKit

struct Color {
    static var clear: UIColor {
        .clear
    }
    
    static var white: UIColor {
        .white
    }
    
    static var white70: UIColor {
        white.withAlphaComponent(0.7)
    }
    
    static var black: UIColor {
        .black
    }
    
    static var black50: UIColor {
        black.withAlphaComponent(0.5)
    }
    
    static var black10: UIColor {
        black.withAlphaComponent(0.1)
    }
    
    static var bg1: UIColor {
        UIColor(hex: 0x197DC8)
    }
    
    static var bg2: UIColor {
        UIColor(hex: 0x328CC8)
    }
    
    static var bg3: UIColor {
        UIColor(hex: 0x4B96C8)
    }
    
    static var bg4: UIColor {
        UIColor(hex: 0x64A0C8)
    }
    
    static var bg5: UIColor {
        UIColor(hex: 0x7DAAC8)
    }
}
