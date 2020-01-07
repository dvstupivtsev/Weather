//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import Foundation
@testable import Weather

extension KeyboardInfo: Equatable {
    public static func == (lhs: KeyboardInfo, rhs: KeyboardInfo) -> Bool {
        lhs.verticalOffset == rhs.verticalOffset && lhs.duration == rhs.duration
    }
}
