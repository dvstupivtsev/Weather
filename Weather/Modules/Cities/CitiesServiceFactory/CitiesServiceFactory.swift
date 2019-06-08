//
//  Created by Dmitriy Stupivtsev on 08/06/2019.
//

import Foundation

struct CitiesServiceFactory {
    func create() -> CitiesService {
        let urlSessionAdapter = UrlSessionAdapter(session: URLSession.shared)
        let apiService = ApiServiceImpl(urlService: urlSessionAdapter)
        let citiesWeatherService = CitiesWeatherServiceImpl(
            apiService: apiService,
            jsonDecoder: CitiesWeatherJsonDecoderImpl()
        )
        
        return CitiesServiceImpl(
            citiesWeatherService: citiesWeatherService,
            timeZoneService: TimeZoneServiceImpl()
        )
    }
}
