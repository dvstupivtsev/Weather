//
//  Created by Dmitriy Stupivtsev on 13/05/2019.
//

import UIKit
import Weakify

final class CitySearchViewController: BaseViewController<CitySearchView> {
    private let viewModel: CitySearchViewModel
    
    init(viewModel: CitySearchViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.setupCloseAction(weakify(self, type(of: self).dismissAnimated))
        customView.setupTextFieldBehavior(CitySearchTextFieldBehavior(delegate: viewModel.textEditingDelegate))
    }
}

extension CitySearchViewController: CitySearchViewUpdatable {
    func update(providerConvertibles: [CellProviderConvertible]) {
        
    }
}
