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
    
    func getCities(for name: String, limit: Int) -> Promise<[CityModel]> {
        return citiesLoadingService
            .getCities()
            .then(on: .global(qos: .userInteractive)) {
                self.filter(citiesModels: $0, name: name, limit: limit)
            }
    }
    
    private func filter(citiesModels: [CityModel], name: String, limit: Int) -> [CityModel] {
        let filteredModels = citiesModels
            .filter { $0.name.lowercased().hasPrefix(name.lowercased()) }
        
        let limit = limit < filteredModels.count ? limit : filteredModels.count
        
        return Array(filteredModels[0..<limit])
    }
}
