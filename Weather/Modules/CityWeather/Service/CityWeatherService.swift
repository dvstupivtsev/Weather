//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation
import Promises

protocol CityWeatherService {
    func getHourlyForecast(for cityId: Int) -> Promise<[HourWeather]>
    func getDailyForecast(for cityId: Int) -> Promise<[DayWeather]>
}

