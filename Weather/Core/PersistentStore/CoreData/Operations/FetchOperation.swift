//
//  Created by Dmitriy Stupivtsev on 02/06/2019.
//

import Foundation
import CoreData
import Prelude
import Optics

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
        guard let context = contextContainer.context else {
            completion(.empty)
            return
        }
        
        context.performAndWait {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                |> \.resultType .~ .dictionaryResultType
                |> \.predicate .~ predicate
                |> \.fetchLimit .~ fetchLimit
            
            do {
                let keyValuePairsArray = try context.fetch(fetchRequest) as? [[String : Any]] ?? .empty
                completion(keyValuePairsArray)
            } catch {
                // TODO: Handle error
            }
        }
    }
}
