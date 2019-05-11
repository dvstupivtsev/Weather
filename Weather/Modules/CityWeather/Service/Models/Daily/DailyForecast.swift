//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

struct DailyForecast: Codable, Equatable {
    let list: [DayWeather]
}
