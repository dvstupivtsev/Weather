//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import Foundation
import Promises
import Prelude

final class CityForecastAdapter: CityForecastService {
    private let forecastService: ForecastService
    
    init(forecastService: ForecastService) {
        self.forecastService = forecastService
    }
    
    func getForecast(for cityId: Int) -> Promise<CityForecast> {
        forecastService.getForecast(for: cityId)
            .then(createCityForecast(from:))
    }
    
    private func createCityForecast(from forecast: [Forecast]) -> CityForecast {
        guard forecast.isNotEmpty else { return CityForecast(hourlyForecast: [], dailyForecast: []) }
        
        let maxForecastsCount = forecast.count < 8 ? forecast.count : 8
        
        // TODO: interpolate, make it 24 hour forecast per hour
        let firstEightForecasts = Array(forecast[0..<maxForecastsCount])
        
        // TODO: refactor this monster
        let dailyForecast: [Forecast] = forecast
            .reduce([Date: [Forecast]]()) {
                let key = $1.date.startOfDay
                var newDict = $0
                var forecastList = newDict[key] ?? []
                forecastList.append($1)
                newDict[key] = forecastList
                return newDict
            }
            .map {
                let value = $0.value.map(^\.temperature.value).reduce(0, +) / Double($0.value.count)
                let min = $0.value.map(^\.temperature.min).min() ?? 0
                let max = $0.value.map(^\.temperature.max).max() ?? 0
                return Forecast(
                    date: $0.key,
                    temperature: Forecast.Temperature(value: value, min: min, max: max),
                    // TODO: replace icons with day icons
                    weather: $0.value.map(^\.weather).first ?? []
                )
            }
            .sorted(by: their(^\.date, <))
        
        return CityForecast(hourlyForecast: firstEightForecasts, dailyForecast: dailyForecast)
    }
}
