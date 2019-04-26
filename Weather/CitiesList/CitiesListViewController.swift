//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit

// TODO: Generic ViewController
final class CitiesListViewController: UIViewController {
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
    }
}

