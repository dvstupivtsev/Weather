//
//  Created by Dmitriy Stupivtsev on 27/04/2019.
//

import XCTest
@testable import Promises
@testable import Weather

final class CitiesViewModelImplTests: XCTestCase {
    private var subject: CitiesViewModelImpl!
    private var store: Store<[CitySource]>!
    private var citiesService: CitiesServiceMock!
    private var dateFormatter: CitiesDateFormatterMock!
    private var router: CitiesRouterMock!
    private var viewUpdatable: CitiesViewUpdatableMock!
    
    override func setUp() {
        super.setUp()
        
        store = .init(state: [])
        citiesService = .init()
        dateFormatter = .init()
        router = .init()
        viewUpdatable = .init()
        dateFormatter.stringFromTimeZoneReturnValue = "StringFromDateTest"
        subject = CitiesViewModelImpl(
            store: store,
            citiesService: citiesService,
            dateFormatter: dateFormatter,
            router: router,
            viewUpdatable: viewUpdatable
        )
    }
    
    func testGetDataSuccess() {
        let expectedSources = self.citiesSources
        citiesService.getCitiesWeatherForReturnValue = Promise(expectedSources)
        
        subject.getData()
        
        XCTAssertEqual(citiesService.getCitiesWeatherForCallsCount, 1)
        XCTAssertEqual(citiesService.getCitiesWeatherForReceivedCitiesIds, store.state.map { $0.city.id })
        
        _testViewSource(viewUpdatable.updateViewSourceReceivedViewSource!, expectedCount: 1, expectedSearchCallsCount: 1)
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(store.state, expectedSources)
        
        _testViewSource(viewUpdatable.updateViewSourceReceivedViewSource!, expectedCount: 1 + store.state.count, expectedSearchCallsCount: 2)
    }
    
    private func _testViewSource(_ viewSource: CitiesViewSource, expectedCount: Int, expectedSearchCallsCount: Int) {
        XCTAssertEqual(viewUpdatable.updateViewSourceReceivedViewSource?.cellProviderConvertibles.count, expectedCount)
        
        let expectedHeaderCellModel = CitiesHeaderCell.Model(title: "Favorite cities", onAddAction: { })
        
        let cellsModels = viewSource.cellProviderConvertibles
        let headerCellModel = cellsModels.first as? CitiesHeaderCell.Model
        
        headerCellModel?.onAddAction()
        XCTAssertEqual(router.openCitySearchCallsCount, expectedSearchCallsCount)
        
        if expectedCount > 1 {
            let expectedCityCellModelsSource = citiesSources.map {
                return CityCell.Model(
                    title: $0.city.name,
                    dateTimeString: dateFormatter.stringFromTimeZoneReturnValue,
                    temperatureString: MeasurementFormatter.celsius.string(from: $0.city.main.temp),
                    weatherIcon: UIImage()
                )
            }
            
            let citiesCellModels = Array(cellsModels[1..<expectedCount]) as? [CityCell.Model] ?? []
            XCTAssertEqual(dateFormatter.stringFromTimeZoneCallsCount, 2)
            XCTAssertEqual(headerCellModel, expectedHeaderCellModel)
            XCTAssertEqual(citiesCellModels, expectedCityCellModelsSource)
            
            _testRouting(for: citiesCellModels, for: citiesSources)
        }
    }
    
    private func _testRouting(for models: [CityCell.Model], for citiesSources: [CitySource]) {
        models.enumerated().forEach { index, model in
            let indexPath = IndexPath(row: index + 1, section: 0)
            XCTAssertTrue(subject.shouldSelect(at: indexPath))
            
            subject.select(at: indexPath)
            let citySource = citiesSources[index]
            XCTAssertEqual(router.openCityWeatherCitySourceReceivedCitySource, citySource)
            
            let callsCount = index + 1
            XCTAssertEqual(router.openCityWeatherCitySourceCallsCount, callsCount)
        }
    }
    
    func testGetDataFailure() {
        citiesService.getCitiesWeatherForReturnValue = Promise(NSError.error(message: "Test"))
        
        subject.getData()
        
        _testViewSource(viewUpdatable.updateViewSourceReceivedViewSource!, expectedCount: 1, expectedSearchCallsCount: 1)
        
        XCTAssertEqual(citiesService.getCitiesWeatherForCallsCount, 1)
        XCTAssertEqual(citiesService.getCitiesWeatherForReceivedCitiesIds, store.state.map { $0.city.id })
        
        XCTAssert(waitForPromises(timeout: 1))
        
        _testViewSource(viewUpdatable.updateViewSourceReceivedViewSource!, expectedCount: 1, expectedSearchCallsCount: 2)
        // TODO: Test when there will be implementation
    }
}

private extension CitiesViewModelImplTests {
    var citiesSources: [CitySource] {
        let cities: [City] = [.city1, .city2]
        let timeZones = [TimeZone.current, TimeZone(secondsFromGMT: 123)!]
        
        return zip(cities, timeZones)
            .map(CitySource.init(city:timeZone:))
    }
}

extension CityCell.Model: Equatable {
    public static func == (lhs: CityCell.Model, rhs: CityCell.Model) -> Bool {
        return lhs.title == rhs.title
            && lhs.temperatureString == rhs.temperatureString
            && lhs.dateTimeString == rhs.dateTimeString
    }
}

extension CitiesHeaderCell.Model: Equatable {
    public static func == (lhs: CitiesHeaderCell.Model, rhs: CitiesHeaderCell.Model) -> Bool {
        return lhs.title == rhs.title
    }
}
