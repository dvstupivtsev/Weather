//
//  Created by Dmitriy Stupivtsev on 16/05/2019.
//

import Foundation
import Promises

final class CitySearchServiceImpl: CitySearchService {
    private let citiesLoadingService: CitiesLoadingService
    private let persistentStore: CitiesPersistentStore
    
    init(citiesLoadingService: CitiesLoadingService, persistentStore: CitiesPersistentStore) {
        self.citiesLoadingService = citiesLoadingService
        self.persistentStore = persistentStore
    }
    
    func getCities(for name: String, limit: Int) -> Promise<[CityModel]> {
        guard limit > 0, name.isEmpty == false else { return Promise([]) }
        
        return citiesLoadingService
            .loadCities()
            .then { self.persistentStore.cities(filteredWith: name, limit: limit) }
    }
}
