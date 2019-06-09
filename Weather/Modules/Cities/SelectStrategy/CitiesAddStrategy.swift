//
//  Created by Dmitriy Stupivtsev on 20/05/2019.
//

import Foundation
import Promises
import Weakify

final class CitiesAddStrategy: CitySearchSelectStrategy {
    private let store: Store<[CitySource]>
    private let citySourceService: CitySourceService
    private let citiesService: CitiesService
    private let router: CitiesAddRouter
    
    init(
        store: Store<[CitySource]>,
        citySourceService: CitySourceService,
        citiesService: CitiesService,
        router: CitiesAddRouter
    ) {
        self.store = store
        self.citySourceService = citySourceService
        self.citiesService = citiesService
        self.router = router
    }
    
    func select(cityModel: CityModel) {
        if store.state.contains(where: { $0.city.id == cityModel.id }) {
            router.closeSearch()
        } else {
            citiesService.getCitiesWeather(for: [cityModel.id])
                .then(weakify(self, type(of: self).store(citiesSources:)))
                .then(weakify(self, type(of: self).closeSearch))
                .catch(weakify(self, type(of: self).present(error:)))
        }
    }
    
    private func store(citiesSources: [CitySource]) -> Promise<Void> {
        store.dispatch(action: AddCitiesSourcesAction(citisSources: citiesSources))
        return citySourceService.insert(cities: citiesSources)
    }
    
    private func closeSearch() {
        router.closeSearch()
    }
    
    private func present(error: Error) {
        router.present(error: error)
    }
}
