//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import XCTest
@testable import Weather

class CityWeatherFactoryImplTests: XCTestCase {
    func testCreate() {
        let subject = CityWeatherFactoryImpl()
        let receivedController = subject.create(with: CitySource(city: .city1, timeZone: .current))
        
        XCTAssert(
            receivedController,
            isKindOf: CityWeatherViewController.self,
            "expected value is \(CityWeatherViewController.self), got \(type(of: receivedController))"
        )
    }
}
