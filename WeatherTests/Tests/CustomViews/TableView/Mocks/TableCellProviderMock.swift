//
//  Created by Dmitriy Stupivtsev on 15/05/2019.
//

import UIKit
@testable import Weather

struct TableCellProviderMock: TableCellProvider {
    static let cell = UITableViewCell()
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        return TableCellProviderMock.cell
    }
}
