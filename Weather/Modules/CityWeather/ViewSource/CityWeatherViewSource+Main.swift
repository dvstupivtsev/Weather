//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

extension CityWeatherViewSource {
    struct Main: Equatable {
        let cityName: String
        let temperatue: String
        let degreeSymbol: String
        let weatherStatus: String
        let dateString: String
    }
}
