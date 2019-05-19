//
//  Created by Dmitriy Stupivtsev on 06/05/2019.
//

import Foundation

protocol TableSelectionBehavior {
    func shouldSelect(at indexPath: IndexPath) -> Bool
    func select(at indexPath: IndexPath)
}
