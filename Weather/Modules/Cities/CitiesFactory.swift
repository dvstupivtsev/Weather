//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit

final class CitiesFactory {
    func create() -> UIViewController {
        let urlSessionAdapter = UrlSessionAdapter(session: URLSession.shared)
        let apiService = ApiServiceImpl(urlService: urlSessionAdapter)
        let citiesWeatherService = CitiesWeatherServiceImpl(apiService: apiService)
        let vm = CitiesViewModelImpl(
            citiesService: CitiesServiceImpl(
                citiesWeatherService: citiesWeatherService,
                timeZoneService: TimeZoneServiceImpl()
            ),
            dateFormatter: CitiesDateFormatterImpl()
        )
        
        return CitiesViewController(viewModel: vm)
    }
}
