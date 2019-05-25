//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import Foundation

protocol KeyboardObserver: AnyObject {
    func startObserving(handler: @escaping Handler<KeyboardInfo>)
}
