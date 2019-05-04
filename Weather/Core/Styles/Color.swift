//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import UIKit

struct Color {
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
    
    static var bg1: UIColor {
        return UIColor(hex: 0x3D6685)
    }
    
    static var bg2: UIColor {
        return UIColor(hex: 0x466D8B)
    }
    
    static var bg3: UIColor {
        return UIColor(hex: 0x4D7491)
    }
    
    static var bg4: UIColor {
        return UIColor(hex: 0x5B7F9B)
    }
    
    static var bg5: UIColor {
        return UIColor(hex: 0x7797AE)
    }
}
