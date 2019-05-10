//
//  Created by Dmitriy Stupivtsev on 27/04/2019.
//

import XCTest
@testable import Promises
@testable import Weather

final class CitiesViewModelImplTests: XCTestCase {
    private var subject: CitiesViewModelImpl!
    private var citiesService: CitiesServiceMock!
    private var dateFormatter: CitiesDateFormatterMock!
    private var router: CitiesRouterMock!
    
    override func setUp() {
        super.setUp()
        
        citiesService = .init()
        dateFormatter = .init()
        router = .init()
        dateFormatter.stringFromTimeZoneReturnValue = "StringFromDateTest"
        subject = CitiesViewModelImpl(
            citiesService: citiesService,
            dateFormatter: dateFormatter,
            router: router
        )
    }
    
    func testGetDataSuccess() {
        citiesService.getCitiesWeatherForReturnValue = Promise<[CitySource]>.pending()
        
        var receivedValue: CitiesViewSource?
        var receivedError: Error?
        subject.getData()
            .then { receivedValue = $0 }
            .catch { receivedError = $0 }
        
        XCTAssertEqual(citiesService.getCitiesWeatherForCallsCount, 1, "should request service")
        XCTAssertEqual(citiesService.getCitiesWeatherForReceivedCitiesIds, citiesIds, "should receive valid cities ids")
        
        let citiesSources = self.citiesSources
        citiesService.getCitiesWeatherForReturnValue.fulfill(citiesSources)
        XCTAssert(waitForPromises(timeout: 1))
        
        let expectedHeaderCellModel = CitiesHeaderCell.Model(title: "Fave cities", onAddAction: { })
        let expectedCityCellModelsSource = citiesSources.map {
            return CityCell.Model(
                title: $0.city.name,
                dateTimeString: dateFormatter.stringFromTimeZoneReturnValue,
                temperatureString: MeasurementFormatter.celsius.string(from: $0.city.main.temp),
                weatherIcon: UIImage()
            )
        }
        
        let receivedCellsModels = receivedValue?.cellProviderConvertibles
        let headerCellModel = receivedCellsModels?.first as? CitiesHeaderCell.Model
        let citiesCellModels = Array(receivedCellsModels![1..<receivedCellsModels!.count]) as? [CityCell.Model] ?? []
        XCTAssertEqual(dateFormatter.stringFromTimeZoneCallsCount, 2)
        compare(expected: expectedHeaderCellModel, received: headerCellModel)
        compare(expected: expectedCityCellModelsSource, received: citiesCellModels)
        XCTAssertNil(receivedError, "shouldn't receive error")
        
        testRouting(for: headerCellModel!)
        testRouting(for: citiesCellModels, for: cities)
    }
    
    private func testRouting(for model: CitiesHeaderCell.Model) {
        model.onAddAction()
        
        XCTAssertEqual(
            router.openCitySearchCallsCount,
            1,
            "expect to open city search once, received calls count: \(router.openCitySearchCallsCount)"
        )
    }
    
    private func testRouting(for models: [CityCell.Model], for cities: [CitiesResponse.City]) {
        models.enumerated().forEach { index, model in
            let indexPath = IndexPath(row: index + 1, section: 0)
            XCTAssertTrue(
                subject.shouldSelect(at: indexPath),
                "expect to should select cell at \(indexPath), got false"
            )
            
            subject.select(at: indexPath)
            let city = cities[index]
            XCTAssertEqual(
                router.openCityWeatherCityReceivedCity,
                city,
                "expect to open city \(city), received \(router.openCityWeatherCityReceivedCity!)"
            )
            
            let callsCount = index + 1
            XCTAssertEqual(
                router.openCityWeatherCityCallsCount,
                callsCount,
                "expect to open city weather \(callsCount) times, received calls count: \(router.openCitySearchCallsCount)"
            )
        }
    }
    
    func testGetDataFailure() {
        citiesService.getCitiesWeatherForReturnValue = Promise<[CitySource]>.pending()
        
        var receivedValue: CitiesViewSource?
        var receivedError: Error?
        subject.getData()
            .then { receivedValue = $0 }
            .catch { receivedError = $0 }
        
        XCTAssertEqual(citiesService.getCitiesWeatherForCallsCount, 1, "should request service")
        XCTAssertEqual(citiesService.getCitiesWeatherForReceivedCitiesIds, citiesIds, "should receive valid cities ids")
        
        let expectedError = NSError.error(message: "Test")
        citiesService.getCitiesWeatherForReturnValue.reject(expectedError)
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertNil(receivedValue, "shouldn't receive data")
        XCTAssertEqual(receivedError as NSError?, expectedError, "should receive error")
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
    
    var cities: [CitiesResponse.City] {
        return [.city1, .city2]
    }
    
    var citiesSources: [CitySource] {
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
