//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit

final class CitiesFactory {
    func create(router: CitiesRouter, store: Store<[CitySource]>) -> UIViewController {
        let urlSessionAdapter = UrlSessionAdapter(session: URLSession.shared)
        let apiService = ApiServiceImpl(urlService: urlSessionAdapter)
        let citiesWeatherService = CitiesWeatherServiceImpl(
            apiService: apiService,
            jsonDecoder: CitiesWeatherJsonDecoderImpl()
        )
        
        let viewUpdatableProxy = CitiesViewUpdatableProxy()
        
        let vm = CitiesViewModelImpl(
            store: store,
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
