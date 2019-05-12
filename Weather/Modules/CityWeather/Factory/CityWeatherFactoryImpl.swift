//
//  Created by Dmitriy Stupivtsev on 06/05/2019.
//

import UIKit

final class CityWeatherFactoryImpl: CityWeatherFactory {
    func create(with citySource: CitySource) -> UIViewController {
        let urlService = UrlSessionAdapter(session: URLSession.shared)
        let apiService = ApiServiceImpl(urlService: urlService)
        let forecastService = ForecastServiceImpl(
            apiService: apiService,
            jsonDecoder: ForecastJsonDecoderImpl()
        )
        
        let formatter = CityWeatherFormatterImpl(
            numberFormatter: NumberFormatter.temperature,
            currentDateFormatter: DateFormatter.EEEE_MMM_dd,
            forecastDateFormatter: DateFormatter.MMM_dd,
            forecastWeekdayDateFormatter: DateFormatter.EEEE,
            temperatureFormatter: MeasurementFormatter.celsius
        )
        
        let viewModel = CityWeatherViewModelImpl(
            citySource: citySource,
            forecastService: forecastService,
            formatter: formatter
        )
        
        return CityWeatherViewController(viewModel: viewModel)
    }
}

