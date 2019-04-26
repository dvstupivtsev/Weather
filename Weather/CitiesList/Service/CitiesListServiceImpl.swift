//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

final class CitiesListServiceImpl: CitiesListService {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getWeather(for citiesIds: [String], completion: @escaping (Result<CitiesListResponse, Error>) -> Void) {
        let joinedCitiesIds = citiesIds.joined(separator: ",")
        
        let request = ApiServiceRequest(
            name: Constants.apiName,
            parameters: [
                Constants.idKey: joinedCitiesIds,
                Constants.unitsKey: Constants.unitsValue
            ]
        )
        
        apiService.execute(request: request) { [weak self] in
            self?.handleGetWeather(result: $0, completion: completion)
        }
    }
    
    private func handleGetWeather(result: Result<Data?, Error>, completion: (Result<CitiesListResponse, Error>) -> Void) {
        do {
            if let response = try result.get().flatMap({ try JSONDecoder().decode(CitiesListResponse.self, from: $0) }) {
                completion(.success(response))
            } else {
                completion(.failure(NSError.common))
            }
        } catch {
            completion(.failure(error))
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
