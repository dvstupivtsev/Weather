//
//  Created by Dmitriy Stupivtsev on 17/05/2019.
//

import Foundation
import Prelude

final class CancellableExecutorImpl: CancellableExecutor {
    private let queue: DispatchQueue
    
    private var workItem: DispatchWorkItem?
    
    init(queue: DispatchQueue) {
        self.queue = queue
    }
    
    func execute(delay: Int, handler: @escaping Handler<Cancellable>) {
        var workItem: DispatchWorkItem?
        workItem = DispatchWorkItem {
            handler(workItem ?? Cancelled())
        }
        
        self.workItem = workItem
        
        workItem.do { queue.asyncAfter(deadline: .now() + .milliseconds(delay), execute: $0) }
    }
    
    func cancel() {
        workItem?.cancel()
        workItem = nil
    }
}
