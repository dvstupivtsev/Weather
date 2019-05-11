//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

struct DayWeather: Equatable {
    let date: Date
    let temp: Temperature
    let weather: [Weather]
}

extension DayWeather: Codable {
    private enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temp
        case weather
    }
}
