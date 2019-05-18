//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit
import Promises

// TODO: Swop cities in table
final class CitiesViewController: BaseViewController<CitiesView> {
    private let viewModel: CitiesViewModel
    
    private lazy var tableSource: TableDataSource = .empty
    
    init(viewModel: CitiesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.registerViews(with: CitiesReusableViewRegistrationDirector())
        
        viewModel.getData()
            .then(on: .main, handleGetDataSuccess(result:))
            .catch(on: .main, handleGetDataFailure(error:))
    }
    
    private func handleGetDataSuccess(result: CitiesViewSource) {
        let sectionSource = TableSectionSource(cellProviderConvertibles: result.cellProviderConvertibles)
        tableSource = TableDataSource(
            sources: [sectionSource],
            selectionBehavior: viewModel.cellSelectionBehavior
        )
        
        customView.update(tableSource: tableSource)
    }
    
    private func handleGetDataFailure(error: Error) {
        // TODO: handle failure
    }
}

