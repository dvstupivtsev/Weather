//
//  Created by Dmitriy Stupivtsev on 27/04/2019.
//

import UIKit

class BaseViewController<View: BaseView>: UIViewController {
    private(set) lazy var customView = View(frame: .zero)
    
    override func loadView() {
        view = customView
    }
}
