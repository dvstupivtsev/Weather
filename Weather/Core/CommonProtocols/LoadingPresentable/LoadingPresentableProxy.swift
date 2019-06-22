//
//  Created by Dmitriy Stupivtsev on 17/06/2019.
//

import Foundation

final class LoadingPresentableProxy: LoadingPresentable {
    weak var wrapped: LoadingPresentable?
    
    func showLoading() {
        wrapped?.showLoading()
    }
    
    func hideLoading() {
        wrapped?.hideLoading()
    }
}
