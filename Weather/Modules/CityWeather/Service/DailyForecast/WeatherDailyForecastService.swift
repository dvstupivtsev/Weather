//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol WeatherDailyForecastService {
    func getDailyForecast(for cityId: Int) -> Promise<[DayWeather]>
}
