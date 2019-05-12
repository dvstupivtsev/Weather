//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

struct Forecast: Equatable {
    let date: Date
    let temperature: Temperature
    let weather: [Weather]
}

extension Forecast: Codable {
    private enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temperature = "main"
        case weather
    }
}
