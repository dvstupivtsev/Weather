//
//  Created by Dmitriy Stupivtsev on 30/05/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol CitiesParsingService {
    func getCities() -> Promise<[CityModel]>
}
