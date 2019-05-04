//
//  Created by Dmitriy Stupivtsev on 04/05/2019.
//

import UIKit

final class CitiesHeaderCellProvider: CellProvider {
    private let model: CitiesHeaderCell.Model
    
    init(model: CitiesHeaderCell.Model) {
        self.model = model
    }
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: CitiesHeaderCell = tableView.dequeue(for: tableView, at: indexPath)
        cell.update(model: model)
        
        return cell
    }
}
