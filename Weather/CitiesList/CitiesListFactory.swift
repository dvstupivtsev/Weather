//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit

final class CitiesListFactory {
    func create() -> UIViewController {
        let urlSessionAdapter = UrlSessionAdapter(session: URLSession.shared)
        let apiService = ApiServiceImpl(urlService: urlSessionAdapter)
        let citiesListService = CitiesListServiceImpl(apiService: apiService)
        let vm = CitiesViewModelImpl(citiesListService: citiesListService)
        
        return CitiesListViewController(viewModel: vm)
    }
}
