//
//  Created by Dmitriy Stupivtsev on 20/05/2019.
//

import Foundation
import Promises
import Weakify

protocol CitySourceService {
    func getCitiesWeather(for citiesIds: [Int]) -> Promise<[CitySource]>
    func getAllCitiesWeather() -> Promise<[CitySource]>
    func insert(cities: [CitySource]) -> Promise<Void>
}

final class CitiesAddStrategy: CitySearchSelectStrategy {
    private let store: Store<[CitySource]>
    private let persistentStore: CitySourcePersistentStore
    private let citiesService: CitiesService
    private let router: CitiesAddRouter
    
    init(
        store: Store<[CitySource]>,
        persistentStore: CitySourcePersistentStore,
        citiesService: CitiesService,
        router: CitiesAddRouter
    ) {
        self.store = store
        self.persistentStore = persistentStore
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
        return persistentStore.insert(cities: citiesSources)
    }
    
    private func closeSearch() {
        router.closeSearch()
    }
    
    private func present(error: Error) {
        router.present(error: error)
    }
}
