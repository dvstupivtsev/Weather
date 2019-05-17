//
//  Created by Dmitriy Stupivtsev on 17/05/2019.
//

import Foundation

struct CitySearchReusableViewRegistrationDirector: TableReusableViewRegistrationDirector {
    func registerViews(using registrator: TableReusableViewRegistrator) {
        registrator.register(type: CitySearchCell.self)
    }
}
