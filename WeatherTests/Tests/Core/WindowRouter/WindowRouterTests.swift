//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import XCTest
@testable import Weather

class WindowRouterTests: XCTestCase {
    func testSetRootWindow() {
        let controllerFactory = ControllerFactoryMock()
        controllerFactory.createReturnValue = Constants.controller
        let subject = WindowRouter(controllerFactory: controllerFactory)
        
        let window = UIWindow()
        subject.setRoot(window: window)
        
        XCTAssertEqual(controllerFactory.createCallsCount, 1, "expected to ask factory once to create controller")
        compare(expected: window.rootViewController, received: controllerFactory.createReturnValue)
    }
}
