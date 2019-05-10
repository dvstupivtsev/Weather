//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import XCTest
@testable import Weather

final class CitiesPageControllerFactoryTests: XCTestCase {
    func testCreate() {
        let subject = CitiesPageControllerFactory()
        let receivedController = subject.create()
        
        XCTAssert(
            receivedController,
            isKindOf: PageViewController.self,
            "expected value is \(PageViewController.self), got \(type(of: receivedController))"
        )
    }
}
