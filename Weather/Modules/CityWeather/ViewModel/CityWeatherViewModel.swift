//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation
import Promises

protocol CityWeatherViewModel {
    var mainSource: CityWeatherViewSource.Main { get }
    
    func getForecastSource() -> Promise<CityWeatherViewSource.Forecast>
}
