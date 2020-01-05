//
//  Created by Dmitriy Stupivtsev on 28/04/2019.
//

import Foundation

extension Array {
    var isNotEmpty: Bool { !isEmpty }
}

// MARK: - FloatingPoint

extension Array where Element: FloatingPoint {
    func average() -> Element {
        count > 0
            ? reduce(0, +) / Element(count)
            : 0
    }
}
