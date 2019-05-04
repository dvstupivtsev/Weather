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
    
    override func setUp() {
        super.setUp()
        
        citiesService = .init()
        dateFormatter = .init()
        dateFormatter.stringFromTimeZoneReturnValue = "StringFromDateTest"
        subject = CitiesViewModelImpl(
            citiesService: citiesService,
            dateFormatter: dateFormatter
        )
    }
    
    func testGetDataSuccess() {
        citiesService.getWeatherForReturnValue = Promise<[CitySource]>.pending()
        
        var receivedValue: CitiesViewSource?
        var receivedError: Error?
        subject.getData()
            .then { receivedValue = $0 }
            .catch { receivedError = $0 }
        
        XCTAssertEqual(citiesService.getWeatherForCallsCount, 1, "should request service")
        XCTAssertEqual(citiesService.getWeatherForReceivedCitiesIds, citiesIds, "should receive valid cities ids")
        
        let citiesSources = self.citiesSources
        citiesService.getWeatherForReturnValue.fulfill(citiesSources)
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
    }
    
    func testGetDataFailure() {
        citiesService.getWeatherForReturnValue = Promise<[CitySource]>.pending()
        
        var receivedValue: CitiesViewSource?
        var receivedError: Error?
        subject.getData()
            .then { receivedValue = $0 }
            .catch { receivedError = $0 }
        
        XCTAssertEqual(citiesService.getWeatherForCallsCount, 1, "should request service")
        XCTAssertEqual(citiesService.getWeatherForReceivedCitiesIds, citiesIds, "should receive valid cities ids")
        
        let expectedError = NSError.error(message: "Test")
        citiesService.getWeatherForReturnValue.reject(expectedError)
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
    
    var citiesSources: [CitySource] {
        let cities = [
            CitiesResponse.City(
                id: 1,
                name: "Name1",
                date: Date(),
                coordinate: .init(lat: 1, lon: 2),
                weather: [.init(icon: "Icon1")],
                main: .init(temp: 1)
            ),
            CitiesResponse.City(
                id: 2,
                name: "Name2",
                date: Date(),
                coordinate: .init(lat: 2, lon: 3),
                weather: [.init(icon: "Icon2")],
                main: .init(temp: 2)
            )
        ]
        
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
