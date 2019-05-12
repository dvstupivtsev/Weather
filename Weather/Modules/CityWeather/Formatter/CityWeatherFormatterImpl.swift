//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import Foundation

final class CityWeatherFormatterImpl: CityWeatherFormatter {
    private let numberFormatter: NumberFormatterProtocol
    private let currentDateFormatter: DateFormatterProtocol
    private let forecastDateFormatter: DateFormatterProtocol
    private let forecastWeekdayDateFormatter: DateFormatterProtocol
    private let temperatureFormatter: MeasurementFormatterProtocol
    
    init(
        numberFormatter: NumberFormatterProtocol,
        currentDateFormatter: DateFormatterProtocol,
        forecastDateFormatter: DateFormatterProtocol,
        forecastWeekdayDateFormatter: DateFormatterProtocol,
        temperatureFormatter: MeasurementFormatterProtocol
    ) {
        self.numberFormatter = numberFormatter
        self.currentDateFormatter = currentDateFormatter
        self.forecastDateFormatter = forecastDateFormatter
        self.forecastWeekdayDateFormatter = forecastWeekdayDateFormatter
        self.temperatureFormatter = temperatureFormatter
    }
    
    func formatTemperatureValue(_ value: Double) -> String {
        return numberFormatter.string(from: value)
    }
    
    func formatCurrentDate(_ date: Date) -> String {
        return currentDateFormatter.string(from: date)
    }
    
    func formatForecastDate(_ date: Date) -> String {
        return forecastDateFormatter.string(from: date)
    }
    
    func formatForecastWeekday(_ date: Date) -> String {
        return forecastWeekdayDateFormatter.string(from: date)
    }
    
    func formatForecastTemperature(_ value: Double) -> String {
        return temperatureFormatter.string(from: value)
    }
}
