//
//  Created by Dmitriy Stupivtsev on 13/05/2019.
//

import Foundation
import Promises

final class CitySearchViewModelImpl: CitySearchViewModel {
    private let service: CitySearchService
    private let viewUpdatable: CitySearchViewUpdatable
    
    private let minimumNumberOfSymbolsToSearch = 2
    
    private lazy var foundCitiesSources = [CellSource]()
    
    var textEditingDelegate: TextEditingDelegate {
        return self
    }
    
    var selectionBehavior: CellSelectionBehavior {
        return self
    }
    
    init(service: CitySearchService, viewUpdatable: CitySearchViewUpdatable) {
        self.service = service
        self.viewUpdatable = viewUpdatable
    }
}

extension CitySearchViewModelImpl: TextEditingDelegate {
    func didChangeText(_ text: String?) {
        // TODO: Cancel previous operation while delay
        getCities(for: text ?? "")
            .then(on: .main, viewUpdatable.update(providerConvertibles:))
            .catch(on: .main) { [weak self] _ in
                self?.viewUpdatable.update(providerConvertibles: [])
            }
    }
    
    private func getCities(for name: String) -> Promise<[CellProviderConvertible]> {
        guard name.count > minimumNumberOfSymbolsToSearch else {
            foundCitiesSources.removeAll()
            return Promise([])
        }
        
        return service.getCities(for: name)
            .then(createProviderConvertibles(from:))
    }
    
    private func createProviderConvertibles(from models: [CityModel]) -> [CellProviderConvertible] {
        return []
    }
}

extension CitySearchViewModelImpl: CellSelectionBehavior {
    func shouldSelect(at indexPath: IndexPath) -> Bool {
        return true
    }
    
    func select(at indexPath: IndexPath) {
        foundCitiesSources[indexPath.row].onSelectAction()
    }
}

private extension CitySearchViewModelImpl {
    struct CellSource {
        let providerConvertible: CellProviderConvertible
        let onSelectAction: Action
    }
}
