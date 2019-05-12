//
//  Created by Dmitriy Stupivtsev on 28/04/2019.
//

import UIKit

// TODO: Rename to TableCellProvider
protocol CellProvider {
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}
