//
//  Created by Dmitriy Stupivtsev on 02/06/2019.
//

import Foundation
import CoreData

final class FetchOperation: Operation {
    private let contextContainer: ManagedObjectContextContainer
    private let entityName: String
    private let predicate: NSPredicate?
    private let fetchLimit: Int
    private let completion: Handler<[[String : Any]]>
    
    init(
        contextContainer: ManagedObjectContextContainer,
        entityName: String,
        predicate: NSPredicate?,
        fetchLimit: Int,
        completion: @escaping Handler<[[String : Any]]>
    ) {
        self.contextContainer = contextContainer
        self.entityName = entityName
        self.predicate = predicate
        self.fetchLimit = fetchLimit
        self.completion = completion
        
        super.init()
    }
    
    override func main() {
        var keyValuePairsArray = [[String : Any]]()
        
        guard let context = contextContainer.context else {
            completion(keyValuePairsArray)
            return
        }
        
        context.performAndWait {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            fetchRequest.resultType = NSFetchRequestResultType.dictionaryResultType
            fetchRequest.predicate = predicate
            fetchRequest.fetchLimit = fetchLimit
            
            do {
                keyValuePairsArray = try context.fetch(fetchRequest) as? [[String : Any]] ?? []
            } catch {
                // TODO: Handle error
            }
        }
        
        completion(keyValuePairsArray)
    }
}
