//
//  Created by Dmitriy Stupivtsev on 02/06/2019.
//

import Foundation
import CoreData

final class CheckCountOperation: Operation {
    private let contextContainer: ManagedObjectContextContainer
    private let entityName: String
    private let completion: Handler<Int>
    
    init(
        contextContainer: ManagedObjectContextContainer,
        entityName: String,
        completion: @escaping Handler<Int>
    ) {
        self.contextContainer = contextContainer
        self.entityName = entityName
        self.completion = completion
        
        super.init()
    }
    
    override func main() {
        var count: Int = 0
        
        guard let context = contextContainer.context else {
            completion(count)
            return
        }
        
        context.performAndWait {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            fetchRequest.resultType = NSFetchRequestResultType.countResultType
            
            do {
                count = try context.count(for: fetchRequest)
            } catch {
                // TODO: Handle error
            }
            
        }
        
        completion(count)
    }
}
