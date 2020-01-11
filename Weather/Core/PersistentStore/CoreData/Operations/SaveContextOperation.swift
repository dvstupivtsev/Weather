//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import Foundation
import CoreData
import Weakify
import Prelude

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
        do {
            try contextContainer.context.filter(^\.hasChanges).map { try $0.save() }
        } catch {
            print("Unable to save changes in context with error: \(error)")
        }
    }
}
