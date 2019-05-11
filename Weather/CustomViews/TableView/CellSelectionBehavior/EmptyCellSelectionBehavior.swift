//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

struct DisabledCellSelectionBehavior: CellSelectionBehavior {
    func shouldSelect(at indexPath: IndexPath) -> Bool { return false }
    func select(at indexPath: IndexPath) { }
}
