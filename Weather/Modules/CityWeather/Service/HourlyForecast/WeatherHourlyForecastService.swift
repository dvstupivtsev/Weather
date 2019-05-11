//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol WeatherHourlyForecastService {
    func getHourlyForecast(for cityId: Int) -> Promise<[HourWeather]>
}
