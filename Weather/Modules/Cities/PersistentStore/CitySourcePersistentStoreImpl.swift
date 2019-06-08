//
//  Created by Dmitriy Stupivtsev on 03/06/2019.
//

import Foundation
import Promises

final class CitySourcePersistentStoreImpl: CitySourcePersistentStore {
    private let persistentStore: PersistentStore
    private let entityName = "CitySourceEntity"
    private let limit = 100
    
    init(persistentStore: PersistentStore) {
        self.persistentStore = persistentStore
    }
    
    func insert(cities: [CitySource]) -> Promise<Void> {
        return Promise(on: .global()) { fulfill, _ in
            let keyValuePairsArray: [[String: Any]] = cities.map {
                [
                    ModelKeys.id: $0.city.id,
                    ModelKeys.name: $0.city.name,
                    ModelKeys.date: $0.city.date,
                    ModelKeys.coordinateLat: $0.city.coordinate.lat,
                    ModelKeys.coordinateLon: $0.city.coordinate.lon,
                    ModelKeys.weatherDescription: $0.city.weather.first?.description ?? "",
                    ModelKeys.weatherIcon: $0.city.weather.first?.icon ?? "",
                    ModelKeys.mainTemp: $0.city.main.temp,
                    ModelKeys.timeZoneSeconds: $0.timeZone.secondsFromGMT(),
                ]
            }
            
            self.persistentStore.insert(keyValuePairsArray, for: self.entityName) {
                fulfill(())
            }
        }
    }
    
    func cities() -> Promise<[CitySource]> {
        return Promise(on: .global()) { [weak self] fulfill, reject in
            guard let self = self else { return }
            self.persistentStore.keyValuePairs(for: self.entityName, predicate: nil, limit: self.limit) {
                let models = self.map(keyValuePairsArray: $0)
                fulfill(models)
            }
        }
    }
    
    private func map(keyValuePairsArray: [[String: Any]]) -> [CitySource] {
        return keyValuePairsArray.compactMap {
            guard
                let id = $0["id"] as? Int,
                let name = $0["name"] as? String,
                let date = $0["date"] as? Date,
                let coordLat = $0["coordinateLat"] as? Double,
                let coordLon = $0["coordinateLon"] as? Double,
                let weatherDesc = $0["weatherDescription"] as? String,
                let weatherIcon = $0["weatherIcon"] as? String,
                let mainTemp = $0["mainTemp"] as? Double,
                let timeZoneSeconds = $0["timeZoneSeconds"] as? Int
            else {
                return nil
            }
            
            return CitySource(
                city: City(
                    id: id,
                    name: name,
                    date: date,
                    coordinate: Coordinate(lat: coordLat, lon: coordLon),
                    weather: [Weather(description: weatherDesc, icon: weatherIcon)],
                    main: City.Main(temp: mainTemp)
                ),
                timeZone: TimeZone(secondsFromGMT: timeZoneSeconds) ?? .current
            )
        }
    }
}

private extension CitySourcePersistentStoreImpl {
    struct ModelKeys {
        static let id = "id"
        static let name = "name"
        static let date = "date"
        static let coordinateLat = "coordinateLat"
        static let coordinateLon = "coordinateLon"
        static let weatherDescription = "weatherDescription"
        static let weatherIcon = "weatherIcon"
        static let mainTemp = "mainTemp"
        static let timeZoneSeconds = "timeZoneSeconds"
    }
}
