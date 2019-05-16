//
//  Created by Dmitriy Stupivtsev on 16/05/2019.
//

import Foundation
import Promises

final class CitySearchServiceImpl: CitySearchService {
    private let citiesLoadingService: CitiesLoadingService
    
    init(citiesLoadingService: CitiesLoadingService) {
        self.citiesLoadingService = citiesLoadingService
    }
    
    func getCities(for name: String) -> Promise<[CityModel]> {
        return citiesLoadingService
            .getCities()
            .then { self.filter(citiesModels: $0, name: name) }
    }
    
    private func filter(citiesModels: [CityModel], name: String) -> [CityModel] {
        return citiesModels.filter { $0.name.lowercased().hasPrefix(name.lowercased()) }
    }
}
