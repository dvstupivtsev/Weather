//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit
import Promises

final class CitiesViewController: BaseViewController<CitiesView>, UITableViewDelegate, UITableViewDataSource {
    private let viewModel: CitiesViewModel
    
    private lazy var tableSource = [CellProvider]()
    private lazy var cellSelectionBehavior = viewModel.cellSelectionBehavior
    
    init(viewModel: CitiesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.register(cellTypes: [CityCell.self, CitiesHeaderCell.self])
        customView.setupTableDelegate(self)
        
        viewModel.getData()
            .then(on: .main, handleGetDataSuccess(result:))
            .catch(on: .main, handleGetDataFailure(error:))
    }
    
    private func handleGetDataSuccess(result: CitiesViewSource) {
        tableSource = result.cellProviderConvertibles.map { $0.cellProvider }
        customView.reloadData()
    }
    
    private func handleGetDataFailure(error: Error) {
        // TODO: handle failure
    }
    
    // TODO: - Move to separated entity
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableSource[indexPath.row].cell(for: tableView, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return cellSelectionBehavior.shouldSelect(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        cellSelectionBehavior.select(at: indexPath)
    }
}

