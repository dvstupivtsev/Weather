//
//  Created by Dmitriy Stupivtsev on 02/06/2019.
//

import Foundation
import Promises

final class CitiesPersistentStoreImpl: CitiesPersistentStore {
    private let persistentStore: PersistentStore
    private let entityName = "CityEntity"
    
    init(persistentStore: PersistentStore) {
        self.persistentStore = persistentStore
    }
    
    func numberOfCities() -> Promise<Int> {
        return Promise<Int>(on: .global()) { fulfill, _ in
            self.persistentStore.count(for: self.entityName) {
                fulfill($0)
            }
        }
    }
    
    func insert(citiesModels: [CityModel]) -> Promise<Void> {
        return Promise(on: .global()) { fulfill, _ in
            let keyValuePairsArray: [[String: Any]] = citiesModels.map {
                [
                    "id": $0.id,
                    "name": $0.name,
                    "country": $0.country
                ]
            }
            
            self.persistentStore.insert(keyValuePairsArray, for: self.entityName) {
                fulfill(())
            }
        }
    }
    
    func cities(filteredWith name: String, limit: Int) -> Promise<[CityModel]> {
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
        return Promise(on: .global()) { [weak self] fulfill, reject in
            guard let self = self else { return }
            self.persistentStore.keyValuePairs(for: self.entityName, predicate: predicate, limit: limit) {
                let models = self.map(keyValuePairsArray: $0)
                fulfill(models)
            }
        }
    }
    
    private func map(keyValuePairsArray: [[String: Any]]) -> [CityModel] {
        return keyValuePairsArray.compactMap {
            guard let id = $0["id"] as? Int, let name = $0["name"] as? String, let country = $0["country"] as? String else {
                return nil
            }
            
            return CityModel(id: id, name: name, country: country)
        }
    }
}
