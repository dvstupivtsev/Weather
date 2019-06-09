//
//  Created by Dmitriy Stupivtsev on 09/06/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol CitySourceService {
    func getCitiesWeather() -> Promise<[CitySource]>
    func insert(cities: [CitySource]) -> Promise<Void>
}
