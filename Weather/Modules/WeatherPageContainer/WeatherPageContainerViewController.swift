//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import UIKit

final class WeatherPageContainerViewController: BaseViewController<WeatherPageContainerView> {
    private let pageViewController: PageViewController
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(pageViewController: PageViewController) {
        self.pageViewController = pageViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.setBackgroundView(DayBackgroundView())
        
        addChild(pageViewController)
        customView.addPageView(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
}
