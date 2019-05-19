//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import UIKit

final class CitySearchRouterImpl: CitySearchRouter {
    private let transitionable: Transitionable
    
    init(transitionable: Transitionable) {
        self.transitionable = transitionable
    }
    
    func close() {
        transitionable.dismiss(animated: true, completion: nil)
    }
    
    func openAlreadyAddedAlert() {
        // TODO: To localizable
        let ac = UIAlertController(
            title: "Failure",
            message: "This city already added to favorite list",
            preferredStyle: .alert
        )
        ac.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            )
        )
        
        transitionable.present(controller: ac, animated: true, completion: nil)
    }
}
