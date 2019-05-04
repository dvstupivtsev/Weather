//
//  Created by Dmitriy Stupivtsev on 04/05/2019.
//

import CoreGraphics

extension CGSize {
    init(edge: CGFloat) {
        self.init(width: edge, height: edge)
    }
    
    init(edge: Double) {
        self.init(width: edge, height: edge)
    }
    
    init(edge: Int) {
        self.init(width: edge, height: edge)
    }
}
