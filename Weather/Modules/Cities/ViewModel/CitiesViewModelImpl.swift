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
            .then(handleGetWeather(response:))
    }
    
    private func handleGetWeather(response: CitiesResponse) -> CitiesViewSource {
        // TODO: Timezone
        let providers = response.data.map {
            return CityCell.Model(
                title: $0.name,
                dateTimeString: dateFormatter.string(from: $0.date),
                temperatureString: MeasurementFormatter.celsius.string(from: $0.main.temp),
                weatherIcon: UIImage()
            )
        }
        
        return CitiesViewSource(cellProviderConvertibles: providers)
    }
}
