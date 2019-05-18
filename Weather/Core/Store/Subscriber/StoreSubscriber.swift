//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import Foundation

protocol StoreSubscriber: AnyStoreSubscriber {
    associatedtype StateType
    
    func update(state: StateType)
}

extension StoreSubscriber {
    func _update(state: Any) {
        guard let state = state as? StateType else { return }
        
        update(state: state)
    }
}
