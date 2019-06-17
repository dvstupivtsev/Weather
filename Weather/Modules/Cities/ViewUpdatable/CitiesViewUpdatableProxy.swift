//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import Foundation

final class CitiesViewUpdatableProxy: CitiesViewUpdatable {
    weak var wrapped: CitiesViewUpdatable?
    
    func update(viewSource: CitiesViewSource) {
        wrapped?.update(viewSource: viewSource)
    }
    
    func showLoading() {
        wrapped?.showLoading()
    }
    
    func hideLoading() {
        wrapped?.hideLoading()
    }
}
