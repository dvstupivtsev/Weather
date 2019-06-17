//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit
import Promises
import Weakify

final class CitiesViewModelImpl: CitiesViewModel {
    // TODO: Inject with protocol
    private let store: Store<[CitySource]>
    private let persistentStore: CitySourceService
    private let service: CitiesService
    private let dateFormatter: CitiesDateFormatter
    private let router: CitiesRouter
    private let viewUpdatable: CitiesViewUpdatable
    
    private lazy var cellsSources = [CellSource]()
    
    var selectionBehavior: TableSelectionBehavior {
        return self
    }
    
    init(
        store: Store<[CitySource]>,
        persistentStore: CitySourceService,
        service: CitiesService,
        dateFormatter: CitiesDateFormatter,
        router: CitiesRouter,
        viewUpdatable: CitiesViewUpdatable
    ) {
        self.store = store
        self.persistentStore = persistentStore
        self.service = service
        self.dateFormatter = dateFormatter
        self.router = router
        self.viewUpdatable = viewUpdatable
        
        store.subscribe(self)
    }
    
    func getData() {
        let citiesSources = store.state
        update(state: citiesSources)
        
        viewUpdatable.showLoading()
        
        persistentStore.getCitiesWeather()
            .then(on: .main, weakify(self, type(of: self).hideLoading))
            .then(on: .main, weakify(self, type(of: self).addCitiesSources(_:)))
            .then { self.service.getCitiesWeather(for: $0.map { $0.city.id }) }
            .then(on: .main, weakify(self, type(of: self).replaceCitiesSources(_:)))
            .then(on: .main, weakify(self, type(of: self).insertToPersistentStore(_:)))
            .catch(on: .main, weakify(self, type(of: self).handleCitiesWeatherFailure(error:)))
    }
    
    private func hideLoading() {
        viewUpdatable.hideLoading()
    }
    
    private func addCitiesSources(_ sources: [CitySource]) {
        store.dispatch(action: AddCitiesSourcesAction(citisSources: sources))
    }
    
    private func replaceCitiesSources(_ sources: [CitySource]) {
        store.dispatch(action: ReplaceCitiesSourcesAction(citisSources: sources))
    }
    
    private func insertToPersistentStore(_ sources: [CitySource]) -> Promise<Void> {
        return persistentStore.insert(cities: sources)
    }
    
    private func handleCitiesWeatherFailure(error: Error) {
        // TODO: Impl
    }
    
    private func openCitySearch() {
        let transitionable = TransitionableProxy()
        let strategy = CitiesAddStrategy(
            store: store,
            citySourceService: persistentStore,
            citiesService: service,
            router: CitiesAddRouterImpl(transitionable: transitionable)
        )
        
        router.openCitySearch(
            selectStrategy: strategy,
            transitionableProxy: transitionable
        )
    }
}

extension CitiesViewModelImpl: StoreSubscriber {
    typealias StateType = [CitySource]
    
    func update(state: [CitySource]) {
        var cellsSources: [CellSource] = state.map { citySource in
            return CellSource(
                // TODO: Add country name to title
                cellProviderConvertible: CityTableCell.Model(
                    title: citySource.city.name,
                    dateTimeString: dateFormatter.string(from: citySource.city.date, timeZone: citySource.timeZone),
                    temperatureString: MeasurementFormatter.celsius.string(from: citySource.city.main.temp),
                    weatherIcon: (citySource.city.weather.first?.icon).flatMap(UIImage.init(named:))
                ),
                onSelectAction: { [weak self] in self?.router.openCityWeather(citySource: citySource) }
            )
        }
        
        cellsSources.insert(
            CellSource(
                cellProviderConvertible: CitiesHeaderTableCell.Model(
                    title: L10n.Cities.title,
                    onAddAction: weakify(self, type(of: self).openCitySearch)
                ),
                onSelectAction: nil
            ),
            at: 0
        )
        
        self.cellsSources = cellsSources
        
        viewUpdatable.update(
            viewSource: CitiesViewSource(
                cellProviderConvertibles: cellsSources.map { $0.cellProviderConvertible }
            )
        )
    }
}

extension CitiesViewModelImpl: TableSelectionBehavior {
    func shouldSelect(at indexPath: IndexPath) -> Bool {
        return cellsSources[indexPath.row].onSelectAction != nil
    }
    
    func select(at indexPath: IndexPath) {
        cellsSources[indexPath.row].onSelectAction?()
    }
}

private extension CitiesViewModelImpl {
    struct CellSource {
        let cellProviderConvertible: TableCellProviderConvertible
        let onSelectAction: Action?
    }
}
