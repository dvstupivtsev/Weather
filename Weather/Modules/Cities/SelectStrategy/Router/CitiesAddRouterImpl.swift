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
    
    func present(error: Error) {
        let ac = UIAlertController(
            title: L10n.Alert.Error.title,
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        ac.addAction(
            UIAlertAction(title: L10n.Alert.ok, style: .default)
        )
        
        transitionable.present(controller: ac, animated: true, completion: nil)
    }
}
