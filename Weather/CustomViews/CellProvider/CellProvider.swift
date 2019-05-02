//
//  Created by Dmitriy Stupivtsev on 28/04/2019.
//

import UIKit

protocol CellProvider {
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}
