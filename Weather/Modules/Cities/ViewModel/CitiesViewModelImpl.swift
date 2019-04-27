//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation
import Promises

final class CitiesViewModelImpl: CitiesViewModel {
    private let citiesService: CitiesService
    
    init(citiesService: CitiesService) {
        self.citiesService = citiesService
    }
    
    func getData() -> Promise<Void> {
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
    
    private func handleGetWeather(response: CitiesResponse) -> Void {
        // TODO: make presentation source
        print(response)
        return ()
    }
}
