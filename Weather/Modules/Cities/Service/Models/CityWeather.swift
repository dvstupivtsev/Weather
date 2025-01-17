//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

struct City: Equatable {
    let id: Int
    let name: String
    let date: Date
    let coordinate: Coordinate
    let weather: [Weather]
    let main: Main
}

extension City: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case weather
        case main
        case date = "dt"
        case coordinate = "coord"
    }
}
