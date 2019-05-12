//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import Foundation
import Promises

final class CityForecastAdapter: CityForecastService {
    private let forecastService: ForecastService
    
    init(forecastService: ForecastService) {
        self.forecastService = forecastService
    }
    
    func getForecast(for cityId: Int) -> Promise<CityForecast> {
        return forecastService.getForecast(for: cityId)
            .then(createCityForecast(from:))
    }
    
    private func createCityForecast(from forecast: [Forecast]) -> CityForecast {
        guard forecast.isNotEmpty else { return CityForecast(hourlyForecast: [], dailyForecast: []) }
        
        let maxForecastsCount = forecast.count < 8 ? forecast.count : 8
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
                let minTemp = $0.value.map { $0.temperature.min }.min() ?? 0
                let maxTemp = $0.value.map { $0.temperature.max }.max() ?? 0
                let averageTemp = $0.value.map { $0.temperature.value }.reduce(0, +) / Double($0.value.count)
                return Forecast(
                    date: $0.key,
                    temperature: Forecast.Temperature(value: averageTemp, min: minTemp, max: maxTemp),
                    weather: $0.value.map { $0.weather }.first ?? []
                )
            }
            .sorted { $0.date < $1.date }
        
        return CityForecast(hourlyForecast: firstEightForecasts, dailyForecast: dailyForecast)
    }
}
