//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import Foundation

protocol AnyStoreSubscriber: AnyObject {
    func _update(state: Any)
}
