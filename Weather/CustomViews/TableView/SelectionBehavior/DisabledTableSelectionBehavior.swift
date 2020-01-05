//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

struct DisabledTableSelectionBehavior: TableSelectionBehavior {
    func shouldSelect(at indexPath: IndexPath) -> Bool { false }
    func select(at indexPath: IndexPath) { }
}
