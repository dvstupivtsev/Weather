//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit
import Promises

// TODO: Generic ViewController
final class CitiesViewController: UIViewController {
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
    
    private func handleGetDataSuccess(result: Void) {
        // TODO: show received source
        let ac = UIAlertController(title: "Success", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(ac, animated: true)
    }
    
    private func handleGetDataFailure(error: Error) {
        // TODO: present error
        let ac = UIAlertController(title: "Failure", message: error.localizedDescription, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(ac, animated: true)
    }
}

