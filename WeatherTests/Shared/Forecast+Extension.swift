//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation
@testable import Weather

extension Forecast {
    static let forecast1 = Forecast(
        date: Constants.date,
        temperature: Forecast.Temperature(value: 5, min: -10, max: 20),
        weather: [Weather(description: "DescTest1", icon: "IconNameTest1")]
    )
    
    static let forecast2 = Forecast(
        date: Constants.date,
        temperature: Forecast.Temperature(value: 50, min: -100, max: 200),
        weather: [Weather(description: "DescTest2", icon: "IconNameTest2")]
    )
}
