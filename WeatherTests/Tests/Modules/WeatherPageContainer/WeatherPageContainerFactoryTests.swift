//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import XCTest
@testable import Weather

final class WeatherPageContainerFactoryTests: XCTestCase {
    func testCreate() {
        let subject = WeatherPageContainerFactory(persistentStore: PersistentStoreMock())
        let receivedController = subject.create()
        
        XCTAssert(
            receivedController,
            isKindOf: WeatherPageContainerViewController.self,
            "expected value is \(WeatherPageContainerViewController.self), got \(type(of: receivedController))"
        )
    }
}
