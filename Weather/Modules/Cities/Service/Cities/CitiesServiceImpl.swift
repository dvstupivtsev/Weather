//
//  Created by Dmitriy Stupivtsev on 04/05/2019.
//

import Foundation
import Promises

final class CitiesServiceImpl: CitiesService {
    private let citiesWeatherService: CitiesWeatherService
    private let timeZoneService: TimeZoneService
    
    init(citiesWeatherService: CitiesWeatherService, timeZoneService: TimeZoneService) {
        self.citiesWeatherService = citiesWeatherService
        self.timeZoneService = timeZoneService
    }
    
    func getWeather(for citiesIds: [String]) -> Promise<[CitySource]> {
        return citiesWeatherService.getWeather(for: citiesIds)
            .then(getAndMergeTimeZones(response:))
    }
    
    private func getAndMergeTimeZones(response: CitiesResponse) -> Promise<[CitySource]> {
        let coordinates = response.data.map { $0.coordinate }
        return timeZoneService.getTimeZones(from: coordinates)
            .then { zip(response.data, $0).map(CitySource.init(city:timeZone:)) }
    }
}
