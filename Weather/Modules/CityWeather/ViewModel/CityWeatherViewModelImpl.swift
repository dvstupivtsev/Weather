//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import UIKit
import Promises
import Weakify
import Prelude

final class CityWeatherViewModelImpl: CityWeatherViewModel {
    private let citySource: CitySource
    private let forecastService: CityForecastService
    private let formatter: CityWeatherFormatter
    
    private(set) lazy var mainSource = createMainSource()
    
    init(
        citySource: CitySource,
        forecastService: CityForecastService,
        formatter: CityWeatherFormatter
    ) {
        self.citySource = citySource
        self.forecastService = forecastService
        self.formatter = formatter
    }
    
    private func createMainSource() -> CityWeatherViewSource.Main {
        CityWeatherViewSource.Main(
            cityName: citySource.city.name.uppercased(),
            temperatue: formatter.formatTemperatureValue(citySource.city.main.temp),
            degreeSymbol: "°",
            weatherStatus: citySource.city.weather.first?.description.uppercased() ?? "",
            dateString: formatter.formatCurrentDate(citySource.city.date).uppercased()
        )
    }
    
    func getForecastSource() -> Promise<CityWeatherViewSource.Forecast> {
        forecastService
            .getForecast(for: citySource.city.id)
            .then(createForecastViewSource(with:))
    }
    
    private func createForecastViewSource(with forecast: CityForecast) -> CityWeatherViewSource.Forecast {
        CityWeatherViewSource.Forecast(
            hourlyProviderConvertibles: createHourlyForecastCellProviders(with: forecast.hourlyForecast),
            dailyProviderConvertibles: createDailyForecastCellProviders(with: forecast.dailyForecast)
        )
    }
    
    private func createHourlyForecastCellProviders(with forecast: [Forecast]) -> [CollectionCellProviderConvertible] {
        forecast.map {
            HourlyForecastCollectionCell.Model(
                dateString: formatter.formatHourlyForecastDate($0.date),
                temperatureString: formatter.formatForecastTemperature($0.temperature.value),
                iconImage: $0.weather.first.flatMap { UIImage(named: $0.icon) } ?? UIImage()
            )
        }
    }
    
    private func createDailyForecastCellProviders(with forecast: [Forecast]) -> [TableCellProviderConvertible] {
        forecast.map {
            DailyForecastTableCell.Model(
                weekdayTitle: formatter.formatForecastWeekday($0.date),
                dateString: formatter.formatForecastDate($0.date),
                weatherImage: $0.weather.first.flatMap { UIImage(named: $0.icon) } ?? UIImage(),
                maxTemperatureString: formatter.formatForecastTemperature($0.temperature.max),
                minTemperatureString: formatter.formatForecastTemperature($0.temperature.min)
            )
        }
    }
}
