//
//  Created by Dmitriy Stupivtsev on 06/05/2019.
//

import UIKit

// sourcery: AutoMockable
protocol CitiesRouter {
    func openCityWeather(citySource: CitySource)
    func openCitySearch(selectStrategy: CitySearchSelectStrategy, transitionableProxy: TransitionableProxy)
}
