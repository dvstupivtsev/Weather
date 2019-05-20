//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import Foundation
import CoreData
import Weakify

final class SaveContextOperation: Operation {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        super.init()
    }
    
    override func main() {
        context.performAndWait(weakify(self, type(of: self).save))
    }
    
    private func save() {
        guard context.hasChanges else { return }
        
        // TODO: isCancelled
        
        do {
            try context.save()
        } catch {
            print("Unable to save changes in context with error: \(error)")
        }
    }
}
