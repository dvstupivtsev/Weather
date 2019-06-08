//
//  Created by Dmitriy Stupivtsev on 16/05/2019.
//

import Foundation
import Promises

final class PersistentCitiesLoadingService: CitiesLoadingService {
    private let service: CitiesParsingService
    private let persistentStore: CitySearchService
    
    private var operation: Promise<Void>?
    
    init(service: CitiesParsingService, persistentStore: CitySearchService) {
        self.service = service
        self.persistentStore = persistentStore
    }
    
    func loadCities() -> Promise<Void> {
        if let operation = operation {
            return operation
        } else {
            let operation = persistentStore.numberOfCities()
                .then(handleCount)
            
            self.operation = operation
            return operation
        }
    }
    
    private func handleCount(_ count: Int) -> Promise<Void> {
        guard count == 0 else { return Promise(()) }
        
        return service.getCities().then(persistentStore.insert(citiesModels:))
    }
}
