//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import Foundation
import CoreData
import Weakify

final class CoreDataStore {
    private let modelName: String
    
    private lazy var contextsStack = [NSManagedObjectContext]()
    private lazy var queue = setupQueue()
    
    init(modelName: String) {
        self.modelName = modelName
        
        queue.addOperation(
            SetupContextStackOperation(
                modelName: modelName,
                completion: weakify(self, type(of: self).update(contextStack:))
            )
        )
    }
    
    private func update(contextStack: [NSManagedObjectContext]) {
        self.contextsStack = contextStack
    }
    
    private func setupQueue() -> OperationQueue {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .utility
        
        return queue
    }
}

extension CoreDataStore: PersistentStore {
    func save() {
        let operations = contextsStack.reversed().map(SaveContextOperation.init(context:))
        queue.addOperations(operations, waitUntilFinished: false)
    }
}
