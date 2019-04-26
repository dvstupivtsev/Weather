//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

extension CitiesListResponse {
    struct City {
        let id: Int
        let name: String
        let date: Date
        let weather: [Weather]
        let main: Main
    }
}

extension CitiesListResponse.City: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case weather
        case main
        case date = "dt"
    }
}
