//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol CitiesWeatherService {
    func getWeather(for citiesIds: [String]) -> Promise<[City]>
}
