//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation
@testable import Weather

extension DayWeather {
    static let weather1 = DayWeather(
        date: Constants.date,
        temp: DayWeather.Temperature(min: -10, max: 20),
        weather: [Weather(description: "DescTest1", icon: "IconNameTest1")]
    )
    
    static let weather2 = DayWeather(
        date: Constants.date,
        temp: DayWeather.Temperature(min: -100, max: 200),
        weather: [Weather(description: "DescTest2", icon: "IconNameTest2")]
    )
}
