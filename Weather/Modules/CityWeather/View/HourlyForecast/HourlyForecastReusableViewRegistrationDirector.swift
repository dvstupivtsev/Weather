//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import UIKit

struct HourlyForecastReusableViewRegistrationDirector: CollectionReusableViewRegistrationDirector {
    func registerViews(using registrator: CollectionReusableViewRegistrator) {
        registrator.register(type: HourlyForecastCollectionCell.self)
    }
}
