//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import Foundation
import CoreData
import Weakify

final class SaveContextOperation: Operation {
    private let contextContainer: ManagedObjectContextContainer
    
    init(contextContainer: ManagedObjectContextContainer) {
        self.contextContainer = contextContainer
        
        super.init()
    }
    
    override func main() {
        contextContainer.context?.performAndWait(weakify(self, type(of: self).save))
    }
    
    private func save() {
        guard let context = contextContainer.context, context.hasChanges else { return }
        
        // TODO: isCancelled
        
        do {
            try context.save()
        } catch {
            print("Unable to save changes in context with error: \(error)")
        }
    }
}
