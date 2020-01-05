//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import Foundation
import CoreData
import Prelude

final class SetupPersistentContainerOperation: Operation {
    private let containerName: String
    private let modelName: String
    private let completion: Handler<NSPersistentContainer?>
    
    init(containerName: String, modelName: String, completion: @escaping Handler<NSPersistentContainer?>) {
        self.containerName = containerName
        self.modelName = modelName
        self.completion = completion
    }
    
    override func main() {
        completion(setupPersistentContainer())
    }
    
    private func setupPersistentContainer() -> NSPersistentContainer? {
        guard let persistentContainer = createPersistentContainer() else { return nil }
        
        let mutex = DispatchSemaphore(value: 1)
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print("Failed to load store: \(error)")
            }
            
            mutex.signal()
        }
        
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        mutex.wait()
        
        return persistentContainer
    }
    
    private func createPersistentContainer() -> NSPersistentContainer? {
        Bundle.main.url(forResource: modelName, withExtension: "momd")
            .flatMap(NSManagedObjectModel.init(contentsOf:))
            .map { NSPersistentContainer(name: containerName, managedObjectModel: $0) }
    }
}
