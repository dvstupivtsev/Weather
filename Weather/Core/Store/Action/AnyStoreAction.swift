//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import Foundation

protocol AnyStoreAction {
    func _modify(state: Any) -> Any
}
