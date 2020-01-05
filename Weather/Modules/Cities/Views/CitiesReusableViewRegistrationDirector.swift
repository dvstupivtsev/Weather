//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import UIKit
import Prelude

struct CitiesReusableViewRegistrationDirector: TableReusableViewRegistrationDirector {
    func registerViews(using registrator: TableReusableViewRegistrator) {
        [CityTableCell.self, CitiesHeaderTableCell.self]
            .forEach(registrator.register(type:))
    }
}
