//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

struct HourWeather: Equatable {
    let date: Date
    let main: Main
    let weather: [Weather]
}

extension HourWeather: Codable {
    private enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
    }
}
