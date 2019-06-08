//
//  Created by Dmitriy Stupivtsev on 02/06/2019.
//

import Foundation
import Promises

final class CitiesPersistentStore: CitySearchService {
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
                    Keys.id: $0.id,
                    Keys.name: $0.name,
                    Keys.country: $0.country
                ]
            }
            
            self.persistentStore.insert(keyValuePairsArray, for: self.entityName) {
                fulfill(())
            }
        }
    }
    
    func getCities(filteredWith name: String, limit: Int) -> Promise<[CityModel]> {
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
        return Promise(on: .global(qos: .userInteractive)) { [weak self] fulfill, reject in
            guard let self = self else { return }
            self.persistentStore.keyValuePairs(for: self.entityName, predicate: predicate, limit: limit) {
                let models = self.map(keyValuePairsArray: $0)
                fulfill(models)
            }
        }
    }
    
    private func map(keyValuePairsArray: [[String: Any]]) -> [CityModel] {
        return keyValuePairsArray.compactMap {
            guard
                let id = $0[Keys.id] as? Int,
                let name = $0[Keys.name] as? String,
                let country = $0[Keys.country] as? String
            else {
                return nil
            }
            
            return CityModel(id: id, name: name, country: country)
        }
    }
}

private extension CitiesPersistentStore {
    struct Keys {
        static let id = "id"
        static let name = "name"
        static let country = "country"
    }
}
