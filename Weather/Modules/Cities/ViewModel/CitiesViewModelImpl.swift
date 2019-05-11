//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation
import Promises
import Weakify

final class CitiesViewModelImpl: CitiesViewModel {
    private let citiesService: CitiesService
    private let dateFormatter: CitiesDateFormatter
    private let router: CitiesRouter
    
    private lazy var cellsSources = [CellSource]()
    
    var cellSelectionBehavior: CellSelectionBehavior {
        return self
    }
    
    init(
        citiesService: CitiesService,
        dateFormatter: CitiesDateFormatter,
        router: CitiesRouter
    ) {
        self.citiesService = citiesService
        self.dateFormatter = dateFormatter
        self.router = router
    }
    
    func getData() -> Promise<CitiesViewSource> {
        let citiesIds = [
            "2950159",
            "2968815",
            "2643743",
            "3128760",
            "4699066",
            "98182",
            "3518326",
            "2664454",
            "1850147",
            "1819729",
        ]
        
        return citiesService.getCitiesWeather(for: citiesIds)
            .then(handleCitiesSources(_:))
    }
    
    private func handleCitiesSources(_ sources: [CitySource]) -> CitiesViewSource {
        var cellsSources: [CellSource] = sources.map { citySource in
            return CellSource(
                cellProviderConvertible: CityCell.Model(
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
                cellProviderConvertible: CitiesHeaderCell.Model(
                    title: L10n.Cities.title,
                    onAddAction: weakify(self, type(of: self).openCitySearch)
                ),
                onSelectAction: nil
            ),
            at: 0
        )
        
        self.cellsSources = cellsSources
        
        return CitiesViewSource(cellProviderConvertibles: cellsSources.map { $0.cellProviderConvertible })
    }
    
    private func openCitySearch() {
        router.openCitySearch()
    }
}

extension CitiesViewModelImpl: CellSelectionBehavior {
    func shouldSelect(at indexPath: IndexPath) -> Bool {
        return cellsSources[indexPath.row].onSelectAction != nil
    }
    
    func select(at indexPath: IndexPath) {
        cellsSources[indexPath.row].onSelectAction?()
    }
}

private extension CitiesViewModelImpl {
    struct CellSource {
        let cellProviderConvertible: CellProviderConvertible
        let onSelectAction: Action?
    }
}
