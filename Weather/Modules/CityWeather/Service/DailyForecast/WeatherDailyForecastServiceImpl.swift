//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation
import Promises

final class WeatherDailyForecastServiceImpl: WeatherDailyForecastService {
    private let apiService: ApiService
    private let jsonDecoder: DailyForecastJsonDecoder
    
    init(apiService: ApiService, jsonDecoder: DailyForecastJsonDecoder) {
        self.apiService = apiService
        self.jsonDecoder = jsonDecoder
    }
    
    func getDailyForecast(for cityId: Int) -> Promise<[DayWeather]> {
        let request = ApiServiceRequest(
            name: Constants.apiName,
            parameters: [Constants.idKey: "\(cityId)"]
        )
        
        return apiService
            .execute(request: request)
            .then(jsonDecoder.parse(data:))
    }
}

private extension WeatherDailyForecastServiceImpl {
    struct Constants {
        static let idKey = "id"
        static let apiName = "forecast/hourly"
    }
}
