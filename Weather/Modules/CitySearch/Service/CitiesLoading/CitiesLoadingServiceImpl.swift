//
//  Created by Dmitriy Stupivtsev on 16/05/2019.
//

import Foundation
import Promises

// TODO: - add pre populated DB with all cities instead of huge json
final class CitiesLoadingServiceImpl: CitiesLoadingService {
    private let diskFileReader: DiskFileReader
    private let jsonDecoder: CitiesLoadingJsonDecoder
    
    private var citiesModels: [CityModel]?
    
    private var currentOperation: Promise<[CityModel]>?
    
    init(diskFileReader: DiskFileReader, jsonDecoder: CitiesLoadingJsonDecoder) {
        self.diskFileReader = diskFileReader
        self.jsonDecoder = jsonDecoder
    }
    
    func getCities() -> Promise<[CityModel]> {
        if let models = citiesModels {
            return Promise(models)
        } else if let currentOperation = self.currentOperation {
            return currentOperation
        } else {
            let operation = Promise<[CityModel]>(on: .global(qos: .userInteractive), decodeCities)
            currentOperation = operation
            return operation
        }
    }
    
    private func decodeCities() throws -> [CityModel] {
        currentOperation = nil
        
        let data = try diskFileReader.data(for: "cities")
        let decodedCities = try jsonDecoder.parse(data: data)
        
        self.citiesModels = decodedCities
        
        return decodedCities
    }
}
