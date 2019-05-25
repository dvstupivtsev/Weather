//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import Foundation
import CoreData

// TODO: isCancelled
final class SetupContextOperation: Operation {
    private let containerName: String
    private let modelName: String
    private let completion: Handler<NSManagedObjectContext?>
    
    init(containerName: String, modelName: String, completion: @escaping Handler<NSManagedObjectContext?>) {
        self.containerName = containerName
        self.modelName = modelName
        self.completion = completion
    }
    
    override func main() {
        completion(loadContext())
    }
    
    private func loadContext() -> NSManagedObjectContext? {
        guard let persistentContainer = createPersistentContainer() else { return nil }
        
        let mutex = DispatchSemaphore(value: 1)
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print("Failed to load store: \(error)")
            }
            
            mutex.signal()
        }
        
        mutex.wait()
        
        return persistentContainer.viewContext
    }
    
    private func createPersistentContainer() -> NSPersistentContainer? {
        let managedObjectModel = Bundle.main.url(forResource: modelName, withExtension: "momd")
            .flatMap(NSManagedObjectModel.init(contentsOf:))
        
        return managedObjectModel.map { NSPersistentContainer(name: containerName, managedObjectModel: $0) }
    }
}
