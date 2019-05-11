//
//  Created by Dmitriy Stupivtsev on 06/05/2019.
//

import UIKit

final class CityWeatherFactoryImpl: CityWeatherFactory {
    func create(for city: City) -> UIViewController {
        return CityWeatherViewController()
    }
}

