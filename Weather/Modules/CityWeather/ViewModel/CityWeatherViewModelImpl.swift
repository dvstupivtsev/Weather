//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation
import Promises
import Weakify

final class CityWeatherViewModelImpl: CityWeatherViewModel {
    private let citySource: CitySource
    private let forecastService: ForecastService
    private let formatter: CityWeatherFormatter
    
    private(set) lazy var mainSource = createMainSource()
    
    init(
        citySource: CitySource,
        forecastService: ForecastService,
        formatter: CityWeatherFormatter
    ) {
        self.citySource = citySource
        self.forecastService = forecastService
        self.formatter = formatter
    }
    
    private func createMainSource() -> CityWeatherViewSource.Main {
        return CityWeatherViewSource.Main(
            cityName: citySource.city.name.uppercased(),
            temperatue: formatter.formatTemperatureValue(citySource.city.main.temp),
            degreeSymbol: "°",
            weatherStatus: citySource.city.weather.first?.description.uppercased() ?? "",
            dateString: formatter.formatCurrentDate(citySource.city.date).uppercased()
        )
    }
    
    func getDailyForecastSource() -> Promise<[CellProviderConvertible]> {
        return forecastService
            .getForecast(for: citySource.city.id)
            .then(createDailyForecastCellProviders(with:))
    }
    
    private func createDailyForecastCellProviders(with dailyForecast: [Forecast]) -> [CellProviderConvertible] {
        return dailyForecast.map {
            DailyForecastCell.Model(
                weekdayTitle: formatter.formatForecastWeekday($0.date),
                dateString: formatter.formatForecastDate($0.date),
                weatherImage: $0.weather.first.flatMap { UIImage(named: $0.icon) } ?? UIImage(),
                maxTemperatureString: formatter.formatForecastTemperature($0.temperature.max),
                minTemperatureString: formatter.formatForecastTemperature($0.temperature.min)
            )
        }
    }
}
