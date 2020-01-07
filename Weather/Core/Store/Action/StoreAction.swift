//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import Foundation
import Prelude

protocol StoreAction: AnyStoreAction {
    associatedtype StateType
    
    func modify(state: StateType) -> StateType
}

extension StoreAction {
    func _modify(state: Any) -> Any {
        guard let typedState = state as? StateType else { return state }

        return modify(state: typedState)
    }
}
