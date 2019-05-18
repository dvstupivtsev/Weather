//
//  Created by Dmitriy Stupivtsev on 16/05/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol CitySearchService {
    // TODO: Request rather than params
    func getCities(for name: String, limit: Int) -> Promise<[CityModel]>
}
