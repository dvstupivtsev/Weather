//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation
import Promises

final class CitiesViewModelImpl: CitiesViewModel {
    private let citiesListService: CitiesListService
    
    init(citiesListService: CitiesListService) {
        self.citiesListService = citiesListService
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
        
        return citiesListService.getWeather(for: citiesIds)
            .then(handleGetWeather(response:))
    }
    
    private func handleGetWeather(response: CitiesListResponse) -> Void {
        // TODO: make presentation source
        print(response)
        return ()
    }
}
