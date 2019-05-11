//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

final class CityWeatherViewModelImpl: CityWeatherViewModel {
    private let citySource: CitySource
    private let numberFormatter: NumberFormatterProtocol
    private let dateFormatter: DateFormatterProtocol
    
    private(set) lazy var mainSource = createMainSource()
    
    init(
        citySource: CitySource,
        numberFormatter: NumberFormatterProtocol,
        dateFormatter: DateFormatterProtocol
    ) {
        self.citySource = citySource
        self.numberFormatter = numberFormatter
        self.dateFormatter = dateFormatter
    }
    
    private func createMainSource() -> CityWeatherViewSource.Main {
        return CityWeatherViewSource.Main(
            cityName: citySource.city.name.uppercased(),
            temperatue: numberFormatter.string(from: citySource.city.main.temp),
            degreeSymbol: "°",
            weatherStatus: citySource.city.weather.first?.description.uppercased() ?? "",
            dateString: dateFormatter.string(from: citySource.city.date).uppercased()
        )
    }
}
