//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit

final class CitiesListFactory {
    func create() -> UIViewController {
        let apiService = ApiServiceImpl(urlService: URLSession.shared)
        let citiesListService = CitiesListServiceImpl(apiService: apiService)
        let vm = CitiesViewModelImpl(citiesListService: citiesListService)
        
        return CitiesListViewController(viewModel: vm)
    }
}
