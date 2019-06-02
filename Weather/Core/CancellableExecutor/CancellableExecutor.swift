//
//  Created by Dmitriy Stupivtsev on 17/05/2019.
//

import Foundation

// sourcery: AutoMockable
protocol CancellableExecutor: AnyObject {
    /// - parameter delay: in milliseconds
    func execute(delay: Int, handler: @escaping Handler<Cancellable>)
    func cancel()
}
