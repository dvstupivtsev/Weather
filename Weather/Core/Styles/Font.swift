//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import UIKit

struct Font {
    static func regular(ofSize size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .regular)
    }
    
    static var regular11: UIFont {
        regular(ofSize: 11)
    }
    
    static var regular13: UIFont {
        regular(ofSize: 13)
    }
    
    static var regular15: UIFont {
        regular(ofSize: 15)
    }
    
    static var regular17: UIFont {
        regular(ofSize: 17)
    }
    
    static var regular30: UIFont {
        regular(ofSize: 30)
    }
    
    static var regular90: UIFont {
        regular(ofSize: 90)
    }
}
