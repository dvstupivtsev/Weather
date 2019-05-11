//
//  Created by Dmitriy Stupivtsev on 06/05/2019.
//

import UIKit

final class CityWeatherFactoryImpl: CityWeatherFactory {
    func create(with citySource: CitySource) -> UIViewController {
        let urlService = UrlSessionAdapter(session: URLSession.shared)
        let apiService = ApiServiceImpl(urlService: urlService)
        
        let cityWeatherService = CityWeatherServiceImpl(
            dailyForecastService: WeatherDailyForecastServiceImpl(
                apiService: apiService,
                jsonDecoder: DailyForecastJsonDecoderImpl()
            ),
            hourlyForecastService: WeatherHourlyForecastServiceImpl(
                apiService: apiService,
                jsonDecoder: HourlyForecastJsonDecoderImpl()
            )
        )
        
        let viewModel = CityWeatherViewModelImpl(
            citySource: citySource,
            numberFormatter: NumberFormatter.temperature,
            dateFormatter: DateFormatter.EEEE_MMM_dd,
            cityWeatherService: cityWeatherService
        )
        
        return CityWeatherViewController(viewModel: viewModel)
    }
}

