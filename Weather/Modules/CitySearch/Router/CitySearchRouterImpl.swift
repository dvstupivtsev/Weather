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
        // TODO: Alert builder, maybe
        let ac = UIAlertController(
            title: L10n.CitySearch.AlreadyAddedAlert.title,
            message: L10n.CitySearch.AlreadyAddedAlert.message,
            preferredStyle: .alert
        )
        ac.addAction(
            UIAlertAction(
                title: L10n.CitySearch.AlreadyAddedAlert.buttonTitle,
                style: .default
            )
        )
        
        transitionable.present(controller: ac, animated: true, completion: nil)
    }
}
