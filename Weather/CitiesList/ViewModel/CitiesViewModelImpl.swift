//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

final class CitiesViewModelImpl: CitiesViewModel {
    private let citiesListService: CitiesListService
    
    init(citiesListService: CitiesListService) {
        self.citiesListService = citiesListService
    }
    
    func getData() {
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
        
        citiesListService.getWeather(for: citiesIds) { [weak self] result in
            self?.handleGetData(result: result)
        }
    }
    
    private func handleGetData(result: Result<CitiesListResponse, Error>) {
        print(result)
    }
}
