//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

extension DayWeather {
    struct Temperature: Codable, Equatable {
        let min: Double
        let max: Double
    }
}
