//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import Foundation
import CoreData
import Weakify

final class CoreDataStore {
    private lazy var queue = setup(OperationQueue()) {
        $0.maxConcurrentOperationCount = 1
        $0.qualityOfService = .utility
    }
    
    private var context: NSManagedObjectContext?
    
    init(containerName: String, modelName: String) {
        queue.addOperation(
            SetupContextOperation(
                containerName: containerName,
                modelName: modelName,
                completion: weakify(self, type(of: self).update(context:))
            )
        )
    }
    
    private func update(context: NSManagedObjectContext?) {
        self.context = context
    }
}

extension CoreDataStore: PersistentStore {
    func save() {
        context
            .map(SaveContextOperation.init(context:))
            .map(queue.addOperation)
    }
}
