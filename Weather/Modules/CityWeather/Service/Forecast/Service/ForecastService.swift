//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol ForecastService {
    func getForecast(for cityId: Int) -> Promise<[Forecast]>
}
