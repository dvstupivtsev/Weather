//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation
import Promises

final class CitiesListServiceImpl: CitiesListService {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getWeather(for citiesIds: [String]) -> Promise<CitiesListResponse> {
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
    
    private func parse(data: Data?) throws -> CitiesListResponse {
        if let response = try data.flatMap({ try JSONDecoder().decode(CitiesListResponse.self, from: $0) }) {
            return response
        } else {
            throw NSError.common
        }
    }
}

private extension CitiesListServiceImpl {
    struct Constants {
        static let idKey = "id"
        static let unitsKey = "units"
        static let unitsValue = "metric"
        static let apiName = "group"
    }
}
