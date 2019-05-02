//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import UIKit

final class CityCellProvider: CellProvider {
    private let model: CityCell.Model
    
    init(model: CityCell.Model) {
        self.model = model
    }
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: CityCell = tableView.dequeue(for: tableView, at: indexPath)
        cell.update(model: model)
        
        return cell
    }
}
