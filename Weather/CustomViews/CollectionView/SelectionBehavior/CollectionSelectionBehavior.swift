//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import Foundation

protocol CollectionSelectionBehavior {
    func shouldSelect(at indexPath: IndexPath) -> Bool
    func select(at indexPath: IndexPath)
}
