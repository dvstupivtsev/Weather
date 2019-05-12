//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import UIKit

struct DailyForecastReusableViewRegistrator: TableReusableViewRegistrator {
    func registerViews(for tableView: UITableView) {
        tableView.register(type: DailyForecastCell.self)
    }
}
