//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation
import Promises

final class WeatherHourlyForecastServiceImpl: WeatherHourlyForecastService {
    private let apiService: ApiService
    private let jsonDecoder: HourlyForecastJsonDecoder
    
    init(apiService: ApiService, jsonDecoder: HourlyForecastJsonDecoder) {
        self.apiService = apiService
        self.jsonDecoder = jsonDecoder
    }
    
    func getHourlyForecast(for cityId: Int) -> Promise<[HourWeather]> {
        let request = ApiServiceRequest(
            name: Constants.apiName,
            parameters: [Constants.idKey: "\(cityId)"]
        )
        
        return apiService
            .execute(request: request)
            .then(jsonDecoder.parse(data:))
    }
}

private extension WeatherHourlyForecastServiceImpl {
    struct Constants {
        static let idKey = "id"
        static let apiName = "forecast/hourly"
    }
}
