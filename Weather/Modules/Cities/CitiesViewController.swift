//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit

// TODO: add swop and remove cells features
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
    }
}

extension CitiesViewController: CitiesViewUpdatable {
    func update(viewSource: CitiesViewSource) {
        let sectionSource = TableSectionSource(cellProviderConvertibles: viewSource.cellProviderConvertibles)
        tableSource = TableDataSource(
            sources: [sectionSource],
            selectionBehavior: viewModel.selectionBehavior
        )
        
        customView.update(tableSource: tableSource)
    }
}
