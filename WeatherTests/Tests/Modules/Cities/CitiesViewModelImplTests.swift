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
        
        XCTAssertEqual(citiesService.getCitiesWeatherForCallsCount, 1, "should request service")
        XCTAssertEqual(citiesService.getCitiesWeatherForReceivedCitiesIds, citiesIds, "should receive valid cities ids")
        
        XCTAssert(waitForPromises(timeout: 1))
        
        let expectedHeaderCellModel = CitiesHeaderCell.Model(title: "Favorite cities", onAddAction: { })
        let expectedCityCellModelsSource = citiesSources.map {
            return CityCell.Model(
                title: $0.city.name,
                dateTimeString: dateFormatter.stringFromTimeZoneReturnValue,
                temperatureString: MeasurementFormatter.celsius.string(from: $0.city.main.temp),
                weatherIcon: UIImage()
            )
        }
        
        XCTAssertEqual(store.state, expectedSources)
        XCTAssertEqual(viewUpdatable.updateViewSourceCallsCount, 1)
        
        let receivedCellsModels = viewUpdatable.updateViewSourceReceivedViewSource?.cellProviderConvertibles
        let headerCellModel = receivedCellsModels?.first as? CitiesHeaderCell.Model
        let citiesCellModels = Array(receivedCellsModels![1..<receivedCellsModels!.count]) as? [CityCell.Model] ?? []
        XCTAssertEqual(dateFormatter.stringFromTimeZoneCallsCount, 2)
        XCTAssertEqual(headerCellModel, expectedHeaderCellModel)
        XCTAssertEqual(citiesCellModels, expectedCityCellModelsSource)
        
        _testRouting(for: headerCellModel!)
        _testRouting(for: citiesCellModels, for: citiesSources)
    }
    
    private func _testRouting(for model: CitiesHeaderCell.Model) {
        model.onAddAction()
        
        XCTAssertEqual(
            router.openCitySearchCallsCount,
            1,
            "expect to open city search once, received calls count: \(router.openCitySearchCallsCount)"
        )
    }
    
    private func _testRouting(for models: [CityCell.Model], for citiesSources: [CitySource]) {
        models.enumerated().forEach { index, model in
            let indexPath = IndexPath(row: index + 1, section: 0)
            XCTAssertTrue(
                subject.shouldSelect(at: indexPath),
                "expect to should select cell at \(indexPath), got false"
            )
            
            subject.select(at: indexPath)
            let citySource = citiesSources[index]
            XCTAssertEqual(router.openCityWeatherCitySourceReceivedCitySource, citySource)
            
            let callsCount = index + 1
            XCTAssertEqual(
                router.openCityWeatherCitySourceCallsCount,
                callsCount,
                "expect to open city weather \(callsCount) times, received calls count: \(router.openCityWeatherCitySourceCallsCount)"
            )
        }
    }
    
    func testGetDataFailure() {
        citiesService.getCitiesWeatherForReturnValue = Promise<[CitySource]>.pending()
        
        subject.getData()
        
        XCTAssertEqual(citiesService.getCitiesWeatherForCallsCount, 1, "should request service")
        XCTAssertEqual(citiesService.getCitiesWeatherForReceivedCitiesIds, citiesIds, "should receive valid cities ids")
        
        let expectedError = NSError.error(message: "Test")
        citiesService.getCitiesWeatherForReturnValue.reject(expectedError)
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(viewUpdatable.updateViewSourceCallsCount, 0)
        // TODO: Test when there will be implementation
    }
}

private extension CitiesViewModelImplTests {
    var citiesIds: [String] {
        return [
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
    }
    
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
