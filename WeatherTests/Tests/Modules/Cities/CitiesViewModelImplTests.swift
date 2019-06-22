//
//  Created by Dmitriy Stupivtsev on 27/04/2019.
//

import XCTest
@testable import Promises
@testable import Weather

final class CitiesViewModelImplTests: XCTestCase {
    private var subject: CitiesViewModelImpl!
    private var store: Store<[CitySource]>!
    private var persistentStore: CitySourceServiceMock!
    private var service: CitiesServiceMock!
    private var dateFormatter: CitiesDateFormatterMock!
    private var router: CitiesRouterMock!
    private var viewUpdatable: CitiesViewUpdatableMock!
    
    override func setUp() {
        super.setUp()
        
        store = .init(state: [])
        persistentStore = .init()
        service = .init()
        dateFormatter = .init()
        router = .init()
        viewUpdatable = .init()
        dateFormatter.stringFromTimeZoneReturnValue = "StringFromDateTest"
        subject = CitiesViewModelImpl(
            store: store,
            persistentStore: persistentStore,
            service: service,
            dateFormatter: dateFormatter,
            router: router,
            viewUpdatable: viewUpdatable
        )
    }
    
    func testGetDataSuccess() {
        let expectedSources = TestData.citiesSources
        persistentStore.getCitiesWeatherReturnValue = Promise(expectedSources)
        service.getCitiesWeatherForReturnValue = Promise(expectedSources)
        persistentStore.insertCitiesReturnValue = Promise(())
        
        subject.getData()
        
        XCTAssertEqual(viewUpdatable.showLoadingCallsCount, 1)
        XCTAssertEqual(persistentStore.getCitiesWeatherCallsCount, 1)
        
        _testViewSource(viewUpdatable.updateViewSourceReceivedViewSource!, expectedCount: 1, expectedSearchCallsCount: 1)
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(viewUpdatable.hideLoadingCallsCount, 1)
        XCTAssertEqual(store.state, expectedSources)
        
        XCTAssertEqual(service.getCitiesWeatherForReceivedCitiesIds, [1, 2])
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(store.state, expectedSources)
        XCTAssertEqual(persistentStore.insertCitiesCallsCount, 1)
        XCTAssertEqual(persistentStore.insertCitiesReceivedCities, expectedSources)
        
        _testViewSource(viewUpdatable.updateViewSourceReceivedViewSource!, expectedCount: 1 + store.state.count, expectedSearchCallsCount: 2)
    }
    
    private func _testViewSource(_ viewSource: CitiesViewSource, expectedCount: Int, expectedSearchCallsCount: Int) {
        XCTAssertEqual(viewUpdatable.updateViewSourceReceivedViewSource?.cellProviderConvertibles.count, expectedCount)
        
        let expectedHeaderCellModel = CitiesHeaderTableCell.Model(title: "Favorite cities", onAddAction: { })
        
        let cellsModels = viewSource.cellProviderConvertibles
        let headerCellModel = cellsModels.first as? CitiesHeaderTableCell.Model
        
        headerCellModel?.onAddAction()
        XCTAssertEqual(router.openCitySearchSelectStrategyTransitionableProxyLoadingPresentableProxyCallsCount, expectedSearchCallsCount)
        
        if expectedCount > 1 {
            let expectedCityCellModelsSource = TestData.citiesSources.map {
                return CityTableCell.Model(
                    title: $0.city.name,
                    dateTimeString: dateFormatter.stringFromTimeZoneReturnValue,
                    temperatureString: MeasurementFormatter.celsius.string(from: $0.city.main.temp),
                    weatherIcon: UIImage()
                )
            }
            
            let citiesCellModels = Array(cellsModels[1..<expectedCount]) as? [CityTableCell.Model] ?? []
            XCTAssertEqual(dateFormatter.stringFromTimeZoneCallsCount, 4)
            XCTAssertEqual(headerCellModel, expectedHeaderCellModel)
            XCTAssertEqual(citiesCellModels, expectedCityCellModelsSource)
            
            _testRouting(for: citiesCellModels, for: TestData.citiesSources)
        }
    }
    
    private func _testRouting(for models: [CityTableCell.Model], for citiesSources: [CitySource]) {
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
        persistentStore.getCitiesWeatherReturnValue = Promise(NSError.error(message: "Test"))
        
        subject.getData()
        
        _testViewSource(viewUpdatable.updateViewSourceReceivedViewSource!, expectedCount: 1, expectedSearchCallsCount: 1)
        
        XCTAssertEqual(viewUpdatable.showLoadingCallsCount, 1)
        XCTAssertEqual(persistentStore.getCitiesWeatherCallsCount, 1)
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(viewUpdatable.hideLoadingCallsCount, 1)
        _testViewSource(viewUpdatable.updateViewSourceReceivedViewSource!, expectedCount: 1, expectedSearchCallsCount: 2)
        // TODO: Test when there will be implementation
    }
}

private extension CitiesViewModelImplTests {
    struct TestData {
        static let citiesSources: [CitySource] = {
            let cities: [City] = [.city1, .city2]
            let timeZones = [TimeZone.current, TimeZone(secondsFromGMT: 123)!]
            
            return zip(cities, timeZones)
                .map(CitySource.init(city:timeZone:))
        }()
    }
}

extension CityTableCell.Model: Equatable {
    public static func == (lhs: CityTableCell.Model, rhs: CityTableCell.Model) -> Bool {
        return lhs.title == rhs.title
            && lhs.temperatureString == rhs.temperatureString
            && lhs.dateTimeString == rhs.dateTimeString
    }
}

extension CitiesHeaderTableCell.Model: Equatable {
    public static func == (lhs: CitiesHeaderTableCell.Model, rhs: CitiesHeaderTableCell.Model) -> Bool {
        return lhs.title == rhs.title
    }
}
