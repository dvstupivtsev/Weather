//
//  Created by Dmitriy Stupivtsev on 16/05/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol CitySearchService {
    func numberOfCities() -> Promise<Int>
    func insert(citiesModels: [CityModel]) -> Promise<Void>
    func getCities(filteredWith name: String, limit: Int) -> Promise<[CityModel]>
}
