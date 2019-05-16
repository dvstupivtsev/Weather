//
//  Created by Dmitriy Stupivtsev on 16/05/2019.
//

import Foundation
import Promises

final class CitiesLoadingServiceImpl: CitiesLoadingService {
    private let diskFileReader: DiskFileReader
    private let jsonDecoder: CitiesLoadingJsonDecoder
    
    private var citiesModels: [CityModel]?
    
    init(diskFileReader: DiskFileReader, jsonDecoder: CitiesLoadingJsonDecoder) {
        self.diskFileReader = diskFileReader
        self.jsonDecoder = jsonDecoder
    }
    
    func getCities() -> Promise<[CityModel]> {
        if let models = citiesModels {
            return Promise(models)
        } else {
            return Promise(on: .global(qos: .userInteractive), decodeCities)
        }
    }
    
    private func decodeCities() throws -> [CityModel] {
        let data = try diskFileReader.data(for: "cities")
        let decodedCities = try jsonDecoder.parse(data: data)
        
        self.citiesModels = decodedCities
        
        return decodedCities
    }
}
