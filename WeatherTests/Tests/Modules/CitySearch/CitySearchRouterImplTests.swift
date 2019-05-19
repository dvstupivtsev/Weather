//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import XCTest
@testable import Weather

final class CitySearchRouterImplTests: XCTestCase {
    private var subject: CitySearchRouterImpl!
    private var transitionable: TransitionableMock!

    override func setUp() {
        super.setUp()
        
        transitionable = .init()
        subject = CitySearchRouterImpl(transitionable: transitionable)
    }

    func testClose() {
        subject.close()
        XCTAssertTrue(transitionable.dismissAnimatedCompletionReceivedArgs!.animated)
        XCTAssertNil(transitionable.dismissAnimatedCompletionReceivedArgs!.completion)
        XCTAssertEqual(transitionable.dismissAnimatedCompletionCallsCount, 1)
    }
    
    func testOpenAlreadyAddedAlert() {
        subject.openAlreadyAddedAlert()
        
        let receivedAlertController = transitionable.presentControllerAnimatedCompletionReceivedArgs?.controller as? UIAlertController
        XCTAssert(transitionable.presentControllerAnimatedCompletionReceivedArgs!.controller, isKindOf: UIAlertController.self)
        XCTAssertEqual(receivedAlertController?.title, "Already added")
        XCTAssertEqual(receivedAlertController?.message, "This city already added to favorite list")
        XCTAssertEqual(receivedAlertController?.preferredStyle, .alert)
        XCTAssertEqual(receivedAlertController?.actions.count, 1)
        XCTAssertEqual(receivedAlertController?.actions.first?.title, "OK")
        XCTAssertEqual(receivedAlertController?.actions.first?.style, .default)
        XCTAssertTrue(transitionable.presentControllerAnimatedCompletionReceivedArgs!.animated)
        XCTAssertNil(transitionable.presentControllerAnimatedCompletionReceivedArgs!.completion)
        XCTAssertEqual(transitionable.presentControllerAnimatedCompletionCallsCount, 1)
    }
}
