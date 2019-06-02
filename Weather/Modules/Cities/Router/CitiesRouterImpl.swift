//
//  Created by Dmitriy Stupivtsev on 06/05/2019.
//

import UIKit

final class CitiesRouterImpl: CitiesRouter {
    private let cityWeatherFactory: CityWeatherFactory
    private let citySearchFactory: CitySearchFactory
    private let persistentStore: CitiesPersistentStore
    
    weak var citiesController: UIViewController?
    weak var pageController: PageViewController?
    
    private var selectedCity: City?
    
    init(
        cityWeatherFactory: CityWeatherFactory,
        citySearchFactory: CitySearchFactory,
        persistentStore: CitiesPersistentStore
    ) {
        self.cityWeatherFactory = cityWeatherFactory
        self.citySearchFactory = citySearchFactory
        self.persistentStore = persistentStore
    }
    
    func openCityWeather(citySource: CitySource) {
        guard let pageController = pageController, let citiesController = citiesController else { return }
        
        if citySource.city != selectedCity {
            let cityController = cityWeatherFactory.create(with: citySource)
            pageController.updateControllers([citiesController, cityController])
            
            selectedCity = citySource.city
        }
        
        // select second controller (with city weather)
        pageController.setCurrentControllerIndex(1)
    }
    
    func openCitySearch(selectStrategy: CitySearchSelectStrategy, transitionableProxy: TransitionableProxy) {
        guard let pageController = pageController else { return }
        
        let citySearchController = citySearchFactory.create(
            selectStrategy: selectStrategy,
            persistentStore: persistentStore
        )
        transitionableProxy.wrapped = citySearchController
        
        pageController.present(citySearchController, animated: true)
    }
}
