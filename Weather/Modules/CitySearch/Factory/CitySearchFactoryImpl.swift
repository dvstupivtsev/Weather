//
//  Created by Dmitriy Stupivtsev on 06/05/2019.
//

import UIKit

// TODO: Tests
final class CitySearchFactoryImpl: CitySearchFactory {
    func create(selectStrategy: CitySearchSelectStrategy) -> UIViewController {
        let viewUpdatableProxy = CitySearchViewUpdatableProxy()
        
        let citiesLoadingService = CitiesLoadingServiceImpl(
            diskFileReader: DiskJsonFileReader(),
            jsonDecoder: CitiesLoadingJsonDecoderImpl()
        )
        let service = CitySearchServiceImpl(citiesLoadingService: citiesLoadingService)
        
        let transitionableProxy = TransitionableProxy()
        
        let vm = CitySearchViewModelImpl(
            service: service,
            executor: CancellableExecutorImpl(queue: .main),
            viewUpdatable: viewUpdatableProxy,
            router: CitySearchRouterImpl(transitionable: transitionableProxy),
            selectStrategy: selectStrategy
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
