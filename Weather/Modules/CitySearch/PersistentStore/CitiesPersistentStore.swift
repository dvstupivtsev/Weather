//
//  Created by Dmitriy Stupivtsev on 02/06/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol CitiesPersistentStore {
    func numberOfCities() -> Promise<Int>
    func insert(citiesModels: [CityModel]) -> Promise<Void>
    func cities(filteredWith name: String, limit: Int) -> Promise<[CityModel]>
}
