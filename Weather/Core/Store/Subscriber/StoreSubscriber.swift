//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import Foundation
import Prelude

protocol StoreSubscriber: AnyStoreSubscriber {
    associatedtype StateType
    
    func update(state: StateType)
}

extension StoreSubscriber {
    func _update(state: Any) {
        update <*> (state as? StateType)
    }
}
