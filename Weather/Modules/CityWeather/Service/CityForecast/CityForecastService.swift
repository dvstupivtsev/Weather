//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol CityForecastService {
    func getForecast(for cityId: Int) -> Promise<CityForecast>
}
