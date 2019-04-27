//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

extension CitiesResponse {
    struct City: Equatable {
        let id: Int
        let name: String
        let date: Date
        let weather: [Weather]
        let main: Main
    }
}

extension CitiesResponse.City: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case weather
        case main
        case date = "dt"
    }
}
