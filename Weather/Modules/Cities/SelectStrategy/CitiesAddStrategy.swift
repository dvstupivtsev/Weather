//
//  Created by Dmitriy Stupivtsev on 20/05/2019.
//

import Foundation
import Weakify

final class CitiesAddStrategy: CitySearchSelectStrategy {
    private let store: Store<[CitySource]>
    private let citiesService: CitiesService
    private let router: CitiesAddRouter
    
    init(
        store: Store<[CitySource]>,
        citiesService: CitiesService,
        router: CitiesAddRouter
    ) {
        self.store = store
        self.citiesService = citiesService
        self.router = router
    }
    
    func select(cityModel: CityModel) {
        if store.state.contains(where: { $0.city.id == cityModel.id }) {
            router.closeSearch()
        } else {
            citiesService.getCitiesWeather(for: [cityModel.id])
                .then(weakify(self, type(of: self).handleCitiesSourcesLoaded(_:)))
                .catch(weakify(self, type(of: self).handleCitiesSourcesFailed(error:)))
        }
    }
    
    private func handleCitiesSourcesLoaded(_ sources: [CitySource]) {
        store.dispatch(action: AddCitiesSourcesAction(citisSources: sources))
        router.closeSearch()
    }
    
    private func handleCitiesSourcesFailed(error: Error) {
        // TODO: Handle error
    }
}
