//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit

final class CitiesFactory {
    func create(router: CitiesRouter) -> UIViewController {
        let urlSessionAdapter = UrlSessionAdapter(session: URLSession.shared)
        let apiService = ApiServiceImpl(urlService: urlSessionAdapter)
        let citiesWeatherService = CitiesWeatherServiceImpl(
            apiService: apiService,
            jsonDecoder: CitiesWeatherJsonDecoderImpl()
        )
        
        let viewUpdatableProxy = CitiesViewUpdatableProxy()
        
        let vm = CitiesViewModelImpl(
            store: Store<[CitySource]>(state: []),
            citiesService: CitiesServiceImpl(
                citiesWeatherService: citiesWeatherService,
                timeZoneService: TimeZoneServiceImpl()
            ),
            dateFormatter: CitiesDateFormatterImpl(),
            router: router,
            viewUpdatable: viewUpdatableProxy
        )
        
        let vc = CitiesViewController(viewModel: vm)
        viewUpdatableProxy.wrapped = vc
        
        return vc
    }
}
