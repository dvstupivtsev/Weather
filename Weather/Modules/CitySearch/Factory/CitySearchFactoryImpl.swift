//
//  Created by Dmitriy Stupivtsev on 06/05/2019.
//

import UIKit

final class CitySearchFactoryImpl: CitySearchFactory {
    private let store: Store<[CitySource]>
    
    init(store: Store<[CitySource]>) {
        self.store = store
    }
    
    func create() -> UIViewController {
        let viewUpdatableProxy = CitySearchViewUpdatableProxy()
        
        let citiesLoadingService = CitiesLoadingServiceImpl(
            diskFileReader: DiskJsonFileReader(),
            jsonDecoder: CitiesLoadingJsonDecoderImpl()
        )
        let searchService = CitySearchServiceImpl(citiesLoadingService: citiesLoadingService)
        
        let urlSessionAdapter = UrlSessionAdapter(session: URLSession.shared)
        let apiService = ApiServiceImpl(urlService: urlSessionAdapter)
        let citiesWeatherService = CitiesWeatherServiceImpl(
            apiService: apiService,
            jsonDecoder: CitiesWeatherJsonDecoderImpl()
        )
        let citiesService = CitiesServiceImpl(
            citiesWeatherService: citiesWeatherService,
            timeZoneService: TimeZoneServiceImpl()
        )
        
        let transitionableProxy = TransitionableProxy()
        
        let vm = CitySearchViewModelImpl(
            store: store,
            searchService: searchService,
            citiesService: citiesService,
            executor: CancellableExecutorImpl(queue: .main),
            viewUpdatable: viewUpdatableProxy,
            router: CitySearchRouterImpl(transitionable: transitionableProxy)
        )
        
        let notificationObserver = NotificationObserverImpl(notificationCenter: NotificationCenter.default)
        let keyboardObserver = KeyboardObserverImpl(notificationObserver: notificationObserver)
        
        let vc = CitySearchViewController(
            viewModel: vm,
            keyboardObserver: keyboardObserver
        )
        
        viewUpdatableProxy.wrapped = vc
        transitionableProxy.wrapped = vc
        
        return vc
    }
}
