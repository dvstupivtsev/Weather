//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation
import Promises

final class CitiesWeatherServiceImpl: CitiesWeatherService {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getWeather(for citiesIds: [String]) -> Promise<[City]> {
        let joinedCitiesIds = citiesIds.joined(separator: ",")
        
        let request = ApiServiceRequest(
            name: Constants.apiName,
            parameters: [
                Constants.idKey: joinedCitiesIds,
                Constants.unitsKey: Constants.unitsValue
            ]
        )
        
        return apiService
            .execute(request: request)
            .then(parse(data:))
    }
    
    private func parse(data: Data?) throws -> [City] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        if let response = try data.flatMap({ try decoder.decode(CitiesResponse.self, from: $0) }) {
            return response.cities
        } else {
            throw NSError.common
        }
    }
}

private extension CitiesWeatherServiceImpl {
    struct Constants {
        static let idKey = "id"
        static let unitsKey = "units"
        static let unitsValue = "metric"
        static let apiName = "group"
    }
}
