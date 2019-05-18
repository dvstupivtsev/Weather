//
//  Created by Dmitriy Stupivtsev on 17/05/2019.
//

import Foundation

final class CancellableExecutorImpl: CancellableExecutor {
    private let queue: DispatchQueue
    
    private var workItem: DispatchWorkItem?
    
    init(queue: DispatchQueue) {
        self.queue = queue
    }
    
    func execute(handler: @escaping (_ operation: Cancellable) -> Void) {
        var workItem: DispatchWorkItem?
        workItem = DispatchWorkItem {
            handler(workItem ?? Cancelled())
        }
        
        self.workItem = workItem
        
        workItem.map(queue.async(execute:))
    }
    
    func cancel() {
        workItem?.cancel()
        workItem = nil
    }
}
