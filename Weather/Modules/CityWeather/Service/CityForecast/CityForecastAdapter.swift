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
        CityForecast(
            hourlyForecast: forecast |> prefix(8) >>> Array.init,
            dailyForecast: forecast.daily
        )
    }
}

private extension Array where Element == Forecast {
    // TODO: refactor this monster
    var daily: [Forecast] {
        reduce([Date: [Forecast]]()) {
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
    }
}
