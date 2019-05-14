//
//  Created by Dmitriy Stupivtsev on 06/05/2019.
//

import UIKit

final class CitySearchFactoryImpl: CitySearchFactory {
    func create() -> UIViewController {
        return CitySearchViewController(viewModel: CitySearchViewModelImpl())
    }
}
