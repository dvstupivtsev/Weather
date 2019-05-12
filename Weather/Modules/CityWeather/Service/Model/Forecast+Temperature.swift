//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

extension Forecast {
    struct Temperature: Equatable {
        let value: Double
        let min: Double
        let max: Double
    }
}

extension Forecast.Temperature: Codable {
    private enum CodingKeys: String, CodingKey {
        case value = "temp"
        case min = "temp_min"
        case max = "temp_max"
    }
}
