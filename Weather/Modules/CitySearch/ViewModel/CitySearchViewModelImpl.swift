//
//  Created by Dmitriy Stupivtsev on 13/05/2019.
//

import Foundation
import Promises

final class CitySearchViewModelImpl: CitySearchViewModel {
    private let service: CitySearchService
    private let executor: CancellableExecutor
    private let viewUpdatable: CitySearchViewUpdatable
    private let router: CitySearchRouter
    private let selectStrategy: CitySearchSelectStrategy
    
    private let filterLimit = 50
    private let delay = 200
    
    private lazy var foundCitiesSources = [CellSource]()
    
    var textEditingDelegate: TextEditingDelegate {
        return self
    }
    
    var selectionBehavior: TableSelectionBehavior {
        return self
    }
    
    init(
        service: CitySearchService,
        executor: CancellableExecutor,
        viewUpdatable: CitySearchViewUpdatable,
        router: CitySearchRouter,
        selectStrategy: CitySearchSelectStrategy
    ) {
        self.service = service
        self.executor = executor
        self.viewUpdatable = viewUpdatable
        self.router = router
        self.selectStrategy = selectStrategy
    }
    
    func close() {
        router.close()
    }
}

extension CitySearchViewModelImpl: TextEditingDelegate {
    func didChangeText(_ text: String?) {
        executor.cancel()
        
        executor.execute(delay: delay) { [weak self] operation in
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
    
    private func getCities(for name: String) -> Promise<[TableCellProviderConvertible]> {
        // TODO: show loading
        return service.getCities(filteredWith: name, limit: filterLimit)
            .then(createProviderConvertibles(from:))
    }
    
    private func createProviderConvertibles(from models: [CityModel]) -> [TableCellProviderConvertible] {
        foundCitiesSources = models.map { cityModel in
            let title = "\(cityModel.name), \(cityModel.country)"
            let model = CitySearchCell.Model(title: title)
            
            return CellSource(providerConvertible: model) { [weak self] in
                self?.selectStrategy.select(cityModel: cityModel)
            }
        }
        
        return foundCitiesSources.map { $0.providerConvertible }
    }
    
    private func handleError(_ error: Error) {
        foundCitiesSources.removeAll()
        viewUpdatable.update(providerConvertibles: [])
    }
}

extension CitySearchViewModelImpl: TableSelectionBehavior {
    func shouldSelect(at indexPath: IndexPath) -> Bool {
        return true
    }
    
    func select(at indexPath: IndexPath) {
        foundCitiesSources[indexPath.row].onSelectAction()
    }
}

private extension CitySearchViewModelImpl {
    struct CellSource {
        let providerConvertible: TableCellProviderConvertible
        let onSelectAction: Action
    }
}
