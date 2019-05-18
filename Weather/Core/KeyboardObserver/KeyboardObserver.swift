//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import Foundation

protocol KeyboardObserver: AnyObject {
    var onChange: Handler<KeyboardInfo>? { get set }
    
    func startObserving()
}