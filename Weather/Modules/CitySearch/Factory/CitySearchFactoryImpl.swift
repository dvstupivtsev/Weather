//
//  Created by Dmitriy Stupivtsev on 06/05/2019.
//

import UIKit

final class CitySearchFactoryImpl: CitySearchFactory {
    func create() -> UIViewController {
        let viewUpdatableProxy = CitySearchViewUpdatableProxy()
        let vm = CitySearchViewModelImpl(viewUpdatable: viewUpdatableProxy)
        let vc = CitySearchViewController(viewModel: vm)
        viewUpdatableProxy.wrapped = vc
        
        return vc
    }
}
