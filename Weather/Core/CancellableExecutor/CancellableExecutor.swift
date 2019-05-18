//
//  Created by Dmitriy Stupivtsev on 17/05/2019.
//

import Foundation

// sourcery: AutoMockable
protocol CancellableExecutor: AnyObject {
    func execute(handler: @escaping (_ operation: Cancellable) -> Void)
    func cancel()
}
