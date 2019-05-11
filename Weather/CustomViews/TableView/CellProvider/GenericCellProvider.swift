//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import UIKit

struct GenericCellProvider<Model, Cell: BaseCell<Model>>: CellProvider {
    private let model: Model
    
    init(model: Model) {
        self.model = model
    }
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeue(for: tableView, at: indexPath)
        cell.update(model: model)
        
        return cell
    }
}
