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
    
    private var persistentContainer: NSPersistentContainer?
    
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

extension CoreDataStore: ManagedObjectContextContainer {
    var context: NSManagedObjectContext? {
        persistentContainer?.viewContext
    }
}

extension CoreDataStore: PersistentStoreCoordinatorContainer {
    var persistentStoreCoordinator: NSPersistentStoreCoordinator? {
        persistentContainer?.persistentStoreCoordinator
    }
}

extension CoreDataStore: PersistentStore {
    func save() {
        queue.addOperation(SaveContextOperation(contextContainer: self))
    }
    
    func insert(_ keyValuePairsArray: [[String: Any]], for entityName: String, completion: @escaping Action) {
        queue.addOperation(
            InsertObjectsOperation(
                contextContainer: self,
                keyValuePairsArray: keyValuePairsArray,
                entityName: entityName,
                completion: completion
            )
        )
    }
    
    func count(for entityName: String, completion: @escaping Handler<Int>) {
        queue.addOperation(
            CheckCountOperation(
                contextContainer: self,
                entityName: entityName,
                completion: completion
            )
        )
    }
    
    func keyValuePairs(
        for entityName: String,
        predicate: NSPredicate?,
        limit: Int,
        completion: @escaping Handler<[[String : Any]]>
    ) {
        queue.addOperation(
            FetchOperation(
                contextContainer: self,
                entityName: entityName,
                predicate: predicate,
                fetchLimit: limit,
                completion: completion
            )
        )
    }
}
