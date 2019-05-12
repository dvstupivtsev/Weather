//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation
import Promises

final class ForecastServiceImpl: ForecastService {
    private let apiService: ApiService
    private let jsonDecoder: ForecastJsonDecoder
    
    init(apiService: ApiService, jsonDecoder: ForecastJsonDecoder) {
        self.apiService = apiService
        self.jsonDecoder = jsonDecoder
    }
    
    func getForecast(for cityId: Int) -> Promise<[Forecast]> {
        let request = ApiServiceRequest(
            name: Constants.apiName,
            parameters: [
                Constants.idKey: "\(cityId)",
                Constants.unitsKey: Constants.unitsValue
            ]
        )
        
        return apiService
            .execute(request: request)
            .then(jsonDecoder.parse(data:))
    }
}

private extension ForecastServiceImpl {
    struct Constants {
        static let apiName = "forecast"
        static let idKey = "id"
        static let unitsKey = "units"
        static let unitsValue = "metric"
    }
}
