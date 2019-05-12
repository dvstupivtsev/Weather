//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import Foundation

// sourcery: AutoMockable
protocol CityWeatherFormatter {
    func formatTemperatureValue(_ value: Double) -> String
    func formatCurrentDate(_ date: Date) -> String
    func formatForecastDate(_ date: Date) -> String
    func formatForecastWeekday(_ date: Date) -> String
    func formatHourlyForecastDate(_ date: Date) -> String
    func formatForecastTemperature(_ value: Double) -> String
}
