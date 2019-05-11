//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import UIKit

final class CityWeatherViewController: BaseViewController<CityWeatherView> {
    private let viewModel: CityWeatherViewModel
    
    init(viewModel: CityWeatherViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.update(mainSource: viewModel.mainSource)
    }
}
