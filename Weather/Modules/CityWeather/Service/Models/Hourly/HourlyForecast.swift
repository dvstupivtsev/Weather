//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

struct HourlyForecast: Codable, Equatable {
    let list: [HourWeather]
}
