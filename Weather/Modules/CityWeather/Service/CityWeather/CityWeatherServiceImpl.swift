//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation
import Promises

final class CityWeatherServiceImpl: CityWeatherService {
    private let dailyForecastService: WeatherDailyForecastService
    private let hourlyForecastService: WeatherHourlyForecastService
    
    init(
        dailyForecastService: WeatherDailyForecastService,
        hourlyForecastService: WeatherHourlyForecastService
    ) {
        self.dailyForecastService = dailyForecastService
        self.hourlyForecastService = hourlyForecastService
    }
    
    func getDailyForecast(for cityId: Int) -> Promise<[DayWeather]> {
        return dailyForecastService.getDailyForecast(for: cityId)
    }
    
    func getHourlyForecast(for cityId: Int) -> Promise<[HourWeather]> {
        return hourlyForecastService.getHourlyForecast(for: cityId)
    }
}
