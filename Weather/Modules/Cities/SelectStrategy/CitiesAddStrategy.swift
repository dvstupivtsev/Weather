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
    private let loadingPresentable: LoadingPresentable
    
    init(
        store: Store<[CitySource]>,
        citySourceService: CitySourceService,
        citiesService: CitiesService,
        router: CitiesAddRouter,
        loadingPresentable: LoadingPresentable
    ) {
        self.store = store
        self.citySourceService = citySourceService
        self.citiesService = citiesService
        self.router = router
        self.loadingPresentable = loadingPresentable
    }
    
    func select(cityModel: CityModel) {
        if store.state.contains(where: { $0.city.id == cityModel.id }) {
            router.closeSearch()
        } else {
            loadingPresentable.showLoading()
            citiesService.getCitiesWeather(for: [cityModel.id])
                .then(on: .main, weakify(self, type(of: self).store(citiesSources:)))
                .then(on: .main, weakify(self, type(of: self).closeSearch))
                .catch(on: .main, weakify(self, type(of: self).present(error:)))
        }
    }
    
    private func store(citiesSources: [CitySource]) -> Promise<Void> {
        store.dispatch(action: AddCitiesSourcesAction(citisSources: citiesSources))
        return citySourceService.insert(cities: citiesSources)
    }
    
    private func closeSearch() {
        loadingPresentable.hideLoading()
        router.closeSearch()
    }
    
    private func present(error: Error) {
        loadingPresentable.hideLoading()
        router.present(error: error)
    }
}
