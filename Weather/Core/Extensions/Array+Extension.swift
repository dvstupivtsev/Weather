//
//  Created by Dmitriy Stupivtsev on 28/04/2019.
//

import Foundation

extension Array {
    var isNotEmpty: Bool {
        return isEmpty == false
    }
}

// MARK: - FloatingPoint

extension Array where Element: FloatingPoint {
    func average() -> Element {
        guard count > 0 else { return 0 }
        
        return reduce(0) { $0 + $1 } / Element(count)
    }
}
