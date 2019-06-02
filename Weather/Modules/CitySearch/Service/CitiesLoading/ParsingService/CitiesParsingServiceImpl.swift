//
//  Created by Dmitriy Stupivtsev on 30/05/2019.
//

import Foundation
import Promises

final class CitiesParsingServiceImpl: CitiesParsingService {
    private let diskFileReader: DiskFileReader
    private let jsonDecoder: CitiesLoadingJsonDecoder
    
    private var citiesModels: [CityModel]?
    
    init(diskFileReader: DiskFileReader, jsonDecoder: CitiesLoadingJsonDecoder) {
        self.diskFileReader = diskFileReader
        self.jsonDecoder = jsonDecoder
    }
    
    func getCities() -> Promise<[CityModel]> {
        return Promise<[CityModel]>(on: .global(qos: .userInteractive), decodeCities)
    }
    
    private func decodeCities() throws -> [CityModel] {
        let data = try diskFileReader.data(for: "cities")
        let decodedCities = try jsonDecoder.parse(data: data)
        
        return decodedCities
    }
}
