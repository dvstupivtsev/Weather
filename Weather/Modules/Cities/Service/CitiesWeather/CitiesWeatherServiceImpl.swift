//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation
import Promises

final class CitiesWeatherServiceImpl: CitiesWeatherService {
    private let apiService: ApiService
    private let jsonDecoder: CitiesWeatherJsonDecoder
    
    init(apiService: ApiService, jsonDecoder: CitiesWeatherJsonDecoder) {
        self.apiService = apiService
        self.jsonDecoder = jsonDecoder
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
            .then(jsonDecoder.parse(data:))
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
