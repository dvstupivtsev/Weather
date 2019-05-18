//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import Foundation

struct NotCancelled: Cancellable {
    var isCancelled: Bool {
        return false
    }
}
