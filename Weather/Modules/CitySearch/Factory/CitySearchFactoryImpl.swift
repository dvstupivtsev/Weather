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
        
        let vc = CitySearchViewController(viewModel: vm)
        viewUpdatableProxy.wrapped = vc
        
        return vc
    }
}
