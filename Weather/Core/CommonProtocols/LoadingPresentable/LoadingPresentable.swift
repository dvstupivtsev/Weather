//
//  Created by Dmitriy Stupivtsev on 17/06/2019.
//

import UIKit

// sourcery: AutoMockable
protocol LoadingPresentable: AnyObject {
    func showLoading()
    func hideLoading()
}

extension LoadingPresentable where Self: UIViewController {
    func showLoading() {
        // TODO: show in separated window
        SVProgressHUD.show()
    }
    
    func hideLoading() {
        SVProgressHUD.dismiss()
    }
}

extension UIViewController: LoadingPresentable { }
