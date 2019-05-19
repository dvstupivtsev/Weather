//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import Foundation
import CoreData

final class SetupContextStackOperation: Operation {
    private let modelName: String
    private let completion: Handler<[NSManagedObjectContext]>
    
    init(modelName: String, completion: @escaping Handler<[NSManagedObjectContext]>) {
        self.modelName = modelName
        self.completion = completion
    }
    
    override func main() {
        completion(setupContextsStack())
    }
    
    private func setupContextsStack() -> [NSManagedObjectContext] {
        guard let coreContext = setupPrivateContext() else { return [] }
        
        let mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.parent = coreContext
        
        return [coreContext, mainContext].compactMap { $0 }
    }
    
    private func setupPrivateContext() -> NSManagedObjectContext? {
        return createPersistentStoreCoordinator().flatMap {
            let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            context.persistentStoreCoordinator = $0
            
            return context
        }
    }
    
    private func createPersistentStoreCoordinator() -> NSPersistentStoreCoordinator? {
        guard
            let coordinator = createManagedObjectModel().map(NSPersistentStoreCoordinator.init(managedObjectModel:)),
            let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else {
            return nil
        }
        
        let storeUrl = documentsDirectoryUrl.appendingPathComponent("\(modelName).sqlite")
        
        do {
            try coordinator.addPersistentStore(
                ofType: NSSQLiteStoreType,
                configurationName: nil,
                at: storeUrl,
                options: [
                    NSMigratePersistentStoresAutomaticallyOption : true,
                    NSInferMappingModelAutomaticallyOption : true
                ]
            )
        } catch {
            return nil
        }
        
        return coordinator
    }
    
    private func createManagedObjectModel() -> NSManagedObjectModel? {
        return Bundle.main.url(forResource: modelName, withExtension: "momd")
            .flatMap(NSManagedObjectModel.init(contentsOf:))
    }
}
