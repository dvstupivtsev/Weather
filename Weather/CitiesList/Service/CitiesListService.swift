//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

// sourcery: AutoMockable
protocol CitiesListService {
    func getWeather(for citiesIds: [String], completion: @escaping ResultHandler<CitiesListResponse>)
}
