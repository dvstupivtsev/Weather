//
//  Created by Dmitriy Stupivtsev on 20/05/2019.
//

import UIKit

final class CitiesAddRouterImpl: CitiesAddRouter {
    private let transitionable: Transitionable
    
    init(transitionable: Transitionable) {
        self.transitionable = transitionable
    }
    
    func closeSearch() {
        transitionable.dismiss(animated: true, completion: nil)
    }
}
