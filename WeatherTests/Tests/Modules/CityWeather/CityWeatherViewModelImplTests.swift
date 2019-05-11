//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import XCTest
@testable import Weather

final class CityWeatherViewModelImplTests: XCTestCase {
    var subject: CityWeatherViewModelImpl!
    var citySource: CitySource!
    var numberFormatter: NumberFormatterProtocolMock!
    var dateFormatter: DateFormatterProtocolMock!
    
    override func setUp() {
        super.setUp()
        
        citySource = CitySource(city: .city1, timeZone: .current)
        
        numberFormatter = .init()
        numberFormatter.stringFromReturnValue = "NumberTest"
        
        dateFormatter = .init()
        dateFormatter.stringFromReturnValue = "DateTest"
        
        subject = CityWeatherViewModelImpl(
            citySource: citySource,
            numberFormatter: numberFormatter,
            dateFormatter: dateFormatter
        )
    }
    
    func testCreateMainSource() {
        let receivedValue = subject.mainSource
        let expectedValue = CityWeatherViewSource.Main(
            cityName: citySource.city.name.uppercased(),
            temperatue: numberFormatter.stringFromReturnValue,
            degreeSymbol: "°",
            weatherStatus: citySource.city.weather.first!.description.uppercased(),
            dateString: dateFormatter.stringFromReturnValue.uppercased()
        )
        
        XCTAssertEqual(receivedValue, expectedValue)
        XCTAssertEqual(numberFormatter.stringFromCallsCount, 1, "expect to call number formatter once, got \(numberFormatter.stringFromCallsCount)")
        XCTAssertEqual(dateFormatter.stringFromCallsCount, 1, "expect to call date formatter once, got \(dateFormatter.stringFromCallsCount)")
    }
}
