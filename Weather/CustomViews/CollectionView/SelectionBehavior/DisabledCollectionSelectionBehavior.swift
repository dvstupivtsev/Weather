//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import Foundation

struct DisabledCollectionSelectionBehavior: CollectionSelectionBehavior {
    func shouldSelect(at indexPath: IndexPath) -> Bool { return false }
    func select(at indexPath: IndexPath) { }
}
