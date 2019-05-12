//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import UIKit

struct CitiesReusableViewRegistrator: TableReusableViewRegistrator {
    func registerViews(for tableView: UITableView) {
        let classes = [CityCell.self, CitiesHeaderCell.self]
        classes.forEach(tableView.register(type:))
    }
}
