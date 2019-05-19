//
//  Created by Dmitriy Stupivtsev on 28/04/2019.
//

import UIKit

protocol TableCellProvider {
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}
