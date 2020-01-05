//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import Foundation

// TODO: add timezone
final class CityWeatherFormatterImpl: CityWeatherFormatter {
    private let numberFormatter: NumberFormatterProtocol
    private let currentDateFormatter: DateFormatterProtocol
    private let forecastDateFormatter: DateFormatterProtocol
    private let forecastWeekdayDateFormatter: DateFormatterProtocol
    private let hourlyForecastDateFormatter: DateFormatterProtocol
    private let temperatureFormatter: MeasurementFormatterProtocol
    
    init(
        numberFormatter: NumberFormatterProtocol,
        currentDateFormatter: DateFormatterProtocol,
        forecastDateFormatter: DateFormatterProtocol,
        forecastWeekdayDateFormatter: DateFormatterProtocol,
        hourlyForecastDateFormatter: DateFormatterProtocol,
        temperatureFormatter: MeasurementFormatterProtocol
    ) {
        self.numberFormatter = numberFormatter
        self.currentDateFormatter = currentDateFormatter
        self.forecastDateFormatter = forecastDateFormatter
        self.forecastWeekdayDateFormatter = forecastWeekdayDateFormatter
        self.hourlyForecastDateFormatter = hourlyForecastDateFormatter
        self.temperatureFormatter = temperatureFormatter
    }
    
    func formatTemperatureValue(_ value: Double) -> String {
        numberFormatter.string(from: value)
    }
    
    func formatCurrentDate(_ date: Date) -> String {
        currentDateFormatter.string(from: date)
    }
    
    func formatForecastDate(_ date: Date) -> String {
        forecastDateFormatter.string(from: date)
    }
    
    func formatForecastWeekday(_ date: Date) -> String {
        forecastWeekdayDateFormatter.string(from: date)
    }
    
    func formatHourlyForecastDate(_ date: Date) -> String {
        hourlyForecastDateFormatter.string(from: date)
    }
    
    func formatForecastTemperature(_ value: Double) -> String {
        temperatureFormatter.string(from: value)
    }
}
