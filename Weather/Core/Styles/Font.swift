//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import UIKit

struct Font {
    static func regular(ofSize size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .regular)
    }
    
    static var regular15: UIFont {
        return regular(ofSize: 15)
    }
    
    static var regular17: UIFont {
        return regular(ofSize: 17)
    }
    
    static var regular40: UIFont {
        return regular(ofSize: 40)
    }
}
