//
//  Created by Dmitriy Stupivtsev on 17/05/2019.
//

import Foundation

// sourcery: AutoMockable
protocol Cancellable {
    var isCancelled: Bool { get }
}

extension DispatchWorkItem: Cancellable { }
