//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation
@testable import Weather

extension HourWeather {
    static let weather1 = HourWeather(
        date: Constants.date,
        main: HourWeather.Main(temp: 1),
        weather: [Weather(description: "DescTest1", icon: "IconNameTest1")]
    )
    
    static let weather2 = HourWeather(
        date: Constants.date,
        main: HourWeather.Main(temp: 2),
        weather: [Weather(description: "DescTest2", icon: "IconNameTest2")]
    )
}
