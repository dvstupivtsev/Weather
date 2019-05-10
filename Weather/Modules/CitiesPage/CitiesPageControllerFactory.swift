//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import UIKit

final class CitiesPageControllerFactory: ControllerFactory {
    func create() -> UIViewController {
        let citiesRouter = CitiesRouterImpl(
            cityWeatherFactory: CityWeatherFactoryImpl(),
            citySearchFactory: CitySearchFactoryImpl()
        )
        
        let citiesController = CitiesFactory().create(router: citiesRouter)
        let pageViewController = PageViewController(controllers: [citiesController])
        citiesRouter.pageController = pageViewController
        citiesRouter.citiesController = citiesController
        
        return pageViewController
    }
}
