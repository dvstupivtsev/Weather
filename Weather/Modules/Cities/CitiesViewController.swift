//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit
import Promises

final class CitiesViewController: BaseViewController<CitiesView> {
    private let viewModel: CitiesViewModel
    
    init(viewModel: CitiesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getData()
            .then(on: .main, handleGetDataSuccess(result:))
            .catch(on: .main, handleGetDataFailure(error:))
    }
    
    private func handleGetDataSuccess(result: CitiesViewSource) {
        title = result.title
    }
    
    private func handleGetDataFailure(error: Error) {
        title = nil
    }
}

