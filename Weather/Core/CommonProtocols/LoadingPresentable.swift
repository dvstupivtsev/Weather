//
//  Created by Dmitriy Stupivtsev on 17/06/2019.
//

import UIKit

protocol LoadingPresentable {
    func showLoading()
    func hideLoading()
}

extension LoadingPresentable where Self: UIViewController {
    func showLoading() {
        SVProgressHUD.show()
    }
    
    func hideLoading() {
        SVProgressHUD.dismiss()
    }
}
