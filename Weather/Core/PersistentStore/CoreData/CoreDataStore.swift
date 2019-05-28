//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import Foundation
import CoreData
import Weakify

final class CoreDataStore: ManagedObjectContextContainer {
    private lazy var queue = setup(OperationQueue()) {
        $0.maxConcurrentOperationCount = 1
        $0.qualityOfService = .utility
    }
    
    private var persistentContainer: NSPersistentContainer?
    
    var context: NSManagedObjectContext? {
        return persistentContainer?.viewContext
    }
    
    init(containerName: String, modelName: String) {
        queue.addOperation(
            SetupPersistentContainerOperation(
                containerName: containerName,
                modelName: modelName,
                completion: weakify(self, type(of: self).update(persistentContainer:))
            )
        )
    }
    
    private func update(persistentContainer: NSPersistentContainer?) {
        self.persistentContainer = persistentContainer
    }
}

extension CoreDataStore: PersistentStore {
    func save() {
        queue.addOperation(SaveContextOperation(contextContainer: self))
    }
    
    func insert(_ keyValuePairsArray: [[String: Any]], for entityName: String) {
        queue.addOperation(
            InsertObjectsOperation(
                contextContainer: self,
                keyValuePairsArray: keyValuePairsArray,
                entityName: entityName
            )
        )
    }
}
