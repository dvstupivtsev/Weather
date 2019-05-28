//
//  Created by Dmitriy Stupivtsev on 25/05/2019.
//

import Foundation
import CoreData
import Weakify

final class InsertObjectsOperation: Operation {
    private let contextContainer: ManagedObjectContextContainer
    private let keyValuePairsArray: [[String: Any]]
    private let entityName: String
    
    init(
        contextContainer: ManagedObjectContextContainer,
        keyValuePairsArray: [[String: Any]],
        entityName: String
    ) {
        self.contextContainer = contextContainer
        self.keyValuePairsArray = keyValuePairsArray
        self.entityName = entityName
        
        super.init()
    }
    
    override func main() {
        contextContainer.context?.performAndWait(weakify(self, type(of: self).insert))
    }
    
    private func insert() {
        guard
            let context = contextContainer.context,
            let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        else {
            return
        }
        
        keyValuePairsArray.forEach {
            let object = NSManagedObject(entity: entity, insertInto: context)
            $0.forEach { object.setValue($0.value, forKey: $0.key) }
        }
        
        do {
            try context.save()
        } catch {
            print("Unable to save data with error: \(error)")
        }
    }
}
