//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import UIKit
import SnapKit

final class WeatherPageContainerView: BaseView {
    private var backgroundView: UIView?
    
    func addPageView(_ view: UIView) {
        if let backgroundView = backgroundView {
            insertSubview(view, aboveSubview: backgroundView)
        } else {
            insertFirst(subview: view)
        }
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setBackgroundView(_ view: UIView) {
        backgroundView?.removeFromSuperview()
        backgroundView = view
        insertFirst(subview: view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
