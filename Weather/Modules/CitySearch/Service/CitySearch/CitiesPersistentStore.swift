//
//  Created by Dmitriy Stupivtsev on 02/06/2019.
//

import Foundation
import Promises
import Overture
import Prelude

final class CitiesPersistentStore: CitySearchService {
    private let persistentStore: PersistentStore
    private let entityName = "CityEntity"
    
    init(persistentStore: PersistentStore) {
        self.persistentStore = persistentStore
    }
    
    func numberOfCities() -> Promise<Int> {
        Promise<Int>(on: .global()) { fulfill, _ in
            self.persistentStore.count(for: self.entityName) {
                fulfill($0)
            }
        }
    }
    
    func insert(citiesModels: [CityModel]) -> Promise<Void> {
        Promise(on: .global()) { fulfill, _ in
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
        Promise(on: .global(qos: .userInteractive)) { [weak self] fulfill, reject in
            guard let self = self else { return }
            
            let predicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
            self.persistentStore.keyValuePairs(for: self.entityName, predicate: predicate, limit: limit) {
                let models = self.map(keyValuePairsArray: $0)
                fulfill(models)
            }
        }
    }
    
    private func map(keyValuePairsArray: [[String: Any]]) -> [CityModel] {
        keyValuePairsArray.compactMap {
            CityModel.init <*> zip(
                $0[Keys.id] as? Int,
                $0[Keys.name] as? String,
                $0[Keys.country] as? String
            )
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
