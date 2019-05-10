//
//  Created by Dmitriy Stupivtsev on 06/05/2019.
//

import UIKit

// sourcery: AutoMockable
protocol CityWeatherFactory {
    func create(for city: CitiesResponse.City) -> UIViewController
}
