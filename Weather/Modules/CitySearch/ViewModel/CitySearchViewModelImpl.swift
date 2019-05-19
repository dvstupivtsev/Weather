//
//  Created by Dmitriy Stupivtsev on 13/05/2019.
//

import Foundation
import Promises
import Weakify

final class CitySearchViewModelImpl: CitySearchViewModel {
    private let store: Store<[CitySource]>
    // TODO: Unite
    private let searchService: CitySearchService
    private let citiesService: CitiesService
    private let executor: CancellableExecutor
    private let viewUpdatable: CitySearchViewUpdatable
    private let router: CitySearchRouter
    
    private let filterLimit = 50
    
    private lazy var foundCitiesSources = [CellSource]()
    
    var textEditingDelegate: TextEditingDelegate {
        return self
    }
    
    var selectionBehavior: CellSelectionBehavior {
        return self
    }
    
    init(
        store: Store<[CitySource]>,
        searchService: CitySearchService,
        citiesService: CitiesService,
        executor: CancellableExecutor,
        viewUpdatable: CitySearchViewUpdatable,
        router: CitySearchRouter
    ) {
        self.store = store
        self.searchService = searchService
        self.citiesService = citiesService
        self.executor = executor
        self.viewUpdatable = viewUpdatable
        self.router = router
    }
    
    func close() {
        router.close()
    }
}

extension CitySearchViewModelImpl: TextEditingDelegate {
    func didChangeText(_ text: String?) {
        executor.cancel()
        
        executor.execute { [weak self] operation in
            self?.getCities(for: text ?? "")
                .then(on: .main) {
                    guard let self = self, operation.isCancelled == false else { return }
                    self.viewUpdatable.update(providerConvertibles: $0)
                }
                .catch(on: .main) {
                    guard let self = self, operation.isCancelled == false else { return }
                    self.handleError($0)
                }
        }
    }
    
    private func getCities(for name: String) -> Promise<[CellProviderConvertible]> {
        // TODO: show loading
        return searchService.getCities(for: name, limit: filterLimit)
            .then(createProviderConvertibles(from:))
    }
    
    private func createProviderConvertibles(from models: [CityModel]) -> [CellProviderConvertible] {
        foundCitiesSources = models.map { cityModel in
            let title = "\(cityModel.name), \(cityModel.country)"
            let model = CitySearchCell.Model(title: title)
            
            return CellSource(providerConvertible: model) { [weak self] in
                self?.select(city: cityModel)
            }
        }
        
        return foundCitiesSources.map { $0.providerConvertible }
    }
    
    private func handleError(_ error: Error) {
        foundCitiesSources.removeAll()
        viewUpdatable.update(providerConvertibles: [])
    }
}

extension CitySearchViewModelImpl: CellSelectionBehavior {
    func shouldSelect(at indexPath: IndexPath) -> Bool {
        return true
    }
    
    func select(at indexPath: IndexPath) {
        foundCitiesSources[indexPath.row].onSelectAction()
    }
    
    private func select(city: CityModel) {
        if store.state.contains(where: { $0.city.id == city.id }) {
            router.openAlreadyAddedAlert()
        } else {
            citiesService.getCitiesWeather(for: ["\(city.id)"])
                .then(weakify(self, type(of: self).handleCitiesSourcesLoaded(_:)))
                .catch(weakify(self, type(of: self).handleCitiesSourcesFailed(error:)))
        }
    }
    
    private func handleCitiesSourcesLoaded(_ sources: [CitySource]) {
        store.dispatch(action: AddCitiesSourcesAction(citisSources: sources))
        router.close()
    }
    
    private func handleCitiesSourcesFailed(error: Error) {
        // TODO: Handle error
    }
}

private extension CitySearchViewModelImpl {
    struct CellSource {
        let providerConvertible: CellProviderConvertible
        let onSelectAction: Action
    }
}
