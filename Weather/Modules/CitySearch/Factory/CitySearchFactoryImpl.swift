//
//  Created by Dmitriy Stupivtsev on 06/05/2019.
//

import UIKit

final class CitySearchFactoryImpl: CitySearchFactory {
    func create() -> UIViewController {
        let viewUpdatableProxy = CitySearchViewUpdatableProxy()
        
        let citiesLoadingService = CitiesLoadingServiceImpl(
            diskFileReader: DiskJsonFileReader(),
            jsonDecoder: CitiesLoadingJsonDecoderImpl()
        )
        let service = CitySearchServiceImpl(citiesLoadingService: citiesLoadingService)
        
        let vm = CitySearchViewModelImpl(
            service: service,
            executor: CancellableExecutorImpl(queue: .main),
            viewUpdatable: viewUpdatableProxy
        )
        
        let notificationObserver = NotificationObserverImpl(notificationCenter: NotificationCenter.default)
        let keyboardObserver = KeyboardObserverImpl(notificationObserver: notificationObserver)
        
        let vc = CitySearchViewController(
            viewModel: vm,
            keyboardObserver: keyboardObserver
        )
        
        viewUpdatableProxy.wrapped = vc
        
        return vc
    }
}
