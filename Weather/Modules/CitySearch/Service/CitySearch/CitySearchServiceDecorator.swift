//
//  Created by Dmitriy Stupivtsev on 02/06/2019.
//

import Foundation
import Promises

final class CitySearchServiceDecorator: CitySearchService {
    private let citiesLoadingService: CitiesLoadingService
    private let persistentStore: CitySearchService
    
    init(citiesLoadingService: CitiesLoadingService, persistentStore: CitySearchService) {
        self.citiesLoadingService = citiesLoadingService
        self.persistentStore = persistentStore
    }
    
    func numberOfCities() -> Promise<Int> {
        persistentStore.numberOfCities()
    }
    
    func insert(citiesModels: [CityModel]) -> Promise<Void> {
        persistentStore.insert(citiesModels: citiesModels)
    }
    
    func getCities(filteredWith name: String, limit: Int) -> Promise<[CityModel]> {
        guard limit > 0, name.isEmpty == false else { return Promise([]) }
        
        return citiesLoadingService
            .loadCities()
            .then { self.persistentStore.getCities(filteredWith: name, limit: limit) }
    }
}
