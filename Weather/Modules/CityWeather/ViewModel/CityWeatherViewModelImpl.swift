//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation
import Promises
import Weakify

final class CityWeatherViewModelImpl: CityWeatherViewModel {
    private let citySource: CitySource
    private let cityWeatherService: CityWeatherService
    
    // TODO: unite in single formatting worker
    private let numberFormatter: NumberFormatterProtocol
    private let mainDateFormatter: DateFormatterProtocol
    private let dailyForecastDateFormatter: DateFormatterProtocol
    private let dailyForecastWeekdayDateFormatter: DateFormatterProtocol
    private let temperatureFormatter: MeasurementFormatterProtocol
    
    private(set) lazy var mainSource = createMainSource()
    
    init(
        citySource: CitySource,
        cityWeatherService: CityWeatherService,
        numberFormatter: NumberFormatterProtocol,
        mainDateFormatter: DateFormatterProtocol,
        dailyForecastDateFormatter: DateFormatterProtocol,
        dailyForecastWeekdayDateFormatter: DateFormatterProtocol,
        temperatureFormatter: MeasurementFormatterProtocol
    ) {
        self.citySource = citySource
        self.cityWeatherService = cityWeatherService
        self.numberFormatter = numberFormatter
        self.mainDateFormatter = mainDateFormatter
        self.dailyForecastDateFormatter = dailyForecastDateFormatter
        self.dailyForecastWeekdayDateFormatter = dailyForecastWeekdayDateFormatter
        self.temperatureFormatter = temperatureFormatter
    }
    
    private func createMainSource() -> CityWeatherViewSource.Main {
        return CityWeatherViewSource.Main(
            cityName: citySource.city.name.uppercased(),
            temperatue: numberFormatter.string(from: citySource.city.main.temp),
            degreeSymbol: "°",
            weatherStatus: citySource.city.weather.first?.description.uppercased() ?? "",
            dateString: mainDateFormatter.string(from: citySource.city.date).uppercased()
        )
    }
    
    func getDailyForecastSource() -> Promise<[CellProviderConvertible]> {
        return cityWeatherService
            .getDailyForecast(for: citySource.city.id)
            .then(createCellProviders(with:))
    }
    
    private func createCellProviders(with dailyForecast: [DayWeather]) -> [CellProviderConvertible] {
        return dailyForecast.map {
            DailyForecastCell.Model(
                weekdayTitle: dailyForecastWeekdayDateFormatter.string(from: $0.date),
                dateString: dailyForecastDateFormatter.string(from: $0.date),
                weatherImage: $0.weather.first.flatMap { UIImage(named: $0.icon) } ?? UIImage(),
                maxTemperatureString: temperatureFormatter.string(from: $0.temp.max),
                minTemperatureString: temperatureFormatter.string(from: $0.temp.min)
            )
        }
    }
}
