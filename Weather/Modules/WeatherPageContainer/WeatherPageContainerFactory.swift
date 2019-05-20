//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import UIKit

final class WeatherPageContainerFactory: ControllerFactory {
    func create() -> UIViewController {
        let store = Store<[CitySource]>(state: [])
        
        let citiesRouter = CitiesRouterImpl(
            cityWeatherFactory: CityWeatherFactoryImpl(),
            citySearchFactory: CitySearchFactoryImpl()
        )
        
        let citiesController = CitiesFactory().create(router: citiesRouter, store: store)
        let pageViewController = PageViewController(controllers: [citiesController])
        citiesRouter.pageController = pageViewController
        citiesRouter.citiesController = citiesController
        
        return WeatherPageContainerViewController(pageViewController: pageViewController)
    }
}
