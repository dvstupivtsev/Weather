//
//  Created by Dmitriy Stupivtsev on 04/05/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol CitiesService {
    func getWeather(for citiesIds: [String]) -> Promise<[CitySource]>
}
