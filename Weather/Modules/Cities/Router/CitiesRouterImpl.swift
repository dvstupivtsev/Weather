//
//  Created by Dmitriy Stupivtsev on 06/05/2019.
//

import UIKit

final class CitiesRouterImpl: CitiesRouter {
    private let cityWeatherFactory: CityWeatherFactory
    private let citySearchFactory: CitySearchFactory
    
    weak var citiesController: UIViewController?
    weak var pageController: PageViewController?
    
    init(cityWeatherFactory: CityWeatherFactory, citySearchFactory: CitySearchFactory) {
        self.cityWeatherFactory = cityWeatherFactory
        self.citySearchFactory = citySearchFactory
    }
    
    func openCityWeather(city: CitiesResponse.City) {
        guard let pageController = pageController, let citiesController = citiesController else { return }
        
        let cityController = cityWeatherFactory.create(for: city)
        pageController.updateControllers([citiesController, cityController])
        
        // select second controller (city weather)
        pageController.setCurrentControllerIndex(1)
    }
    
    func openCitySearch() {
        guard let pageController = pageController else { return }
        
        let citySearchController = citySearchFactory.create()
        pageController.present(citySearchController, animated: true)
    }
}
