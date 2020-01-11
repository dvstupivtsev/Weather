//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import Foundation

extension CityWeatherViewSource {
    struct Forecast {
        let hourlyProviderConvertibles: [CollectionCellProviderConvertible]
        let dailyProviderConvertibles: [TableCellProviderConvertible]
        
        static var empty: Forecast {
            Forecast(hourlyProviderConvertibles: .empty, dailyProviderConvertibles: .empty)
        }
    }
}
