//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import UIKit

// TODO: Tests
final class CitySearchRouterImpl: CitySearchRouter {
    private let transitionable: Transitionable
    
    init(transitionable: Transitionable) {
        self.transitionable = transitionable
    }
    
    func close() {
        transitionable.dismiss(animated: true, completion: nil)
    }
}
