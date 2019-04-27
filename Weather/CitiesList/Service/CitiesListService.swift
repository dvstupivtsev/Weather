//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol CitiesListService {
    func getWeather(for citiesIds: [String]) -> Promise<CitiesListResponse>
}
