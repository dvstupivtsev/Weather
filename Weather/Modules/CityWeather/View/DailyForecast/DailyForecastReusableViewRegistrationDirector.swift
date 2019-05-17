//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import UIKit

struct DailyForecastReusableViewRegistrationDirector: TableReusableViewRegistrationDirector {
    func registerViews(using registrator: TableReusableViewRegistrator) {
        registrator.register(type: DailyForecastCell.self)
    }
}

