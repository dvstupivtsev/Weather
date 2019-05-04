//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation
import Promises

final class CitiesViewModelImpl: CitiesViewModel {
    private let citiesService: CitiesService
    private let dateFormatter: CitiesDateFormatter
    
    init(
        citiesService: CitiesService,
        dateFormatter: CitiesDateFormatter
    ) {
        self.citiesService = citiesService
        self.dateFormatter = dateFormatter
    }
    
    func getData() -> Promise<CitiesViewSource> {
        let citiesIds = [
            "2950159",
            "2968815",
            "2643743",
            "3128760",
            "4699066",
            "98182",
            "3518326",
            "2664454",
            "1850147",
            "1819729",
        ]
        
        return citiesService.getWeather(for: citiesIds)
            .then(handleCitiesSources(_:))
    }
    
    private func handleCitiesSources(_ sources: [CitySource]) -> CitiesViewSource {
        let providers = sources.map {
            return CityCell.Model(
                title: $0.city.name,
                dateTimeString: dateFormatter.string(from: $0.city.date, timeZone: $0.timeZone),
                temperatureString: MeasurementFormatter.celsius.string(from: $0.city.main.temp),
                weatherIcon: ($0.city.weather.first?.icon).flatMap(UIImage.init(named:))
            )
        }
        
        return CitiesViewSource(cellProviderConvertibles: providers)
    }
}
