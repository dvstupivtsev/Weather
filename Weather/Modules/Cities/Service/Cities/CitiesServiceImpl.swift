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
    
    func getCitiesWeather(for citiesIds: [Int]) -> Promise<[CitySource]> {
        return citiesWeatherService.getWeather(for: citiesIds.map(String.init))
            .then(mergeTimeZones(with:))
    }
    
    private func mergeTimeZones(with cities: [City]) -> Promise<[CitySource]> {
        let coordinates = cities.map { $0.coordinate }
        return timeZoneService.getTimeZones(from: coordinates).then {
            zip(cities, $0).map(CitySource.init(city:timeZone:))
        }
    }
}
