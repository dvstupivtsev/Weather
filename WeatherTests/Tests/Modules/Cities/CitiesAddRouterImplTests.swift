//
//  Created by Dmitriy Stupivtsev on 25/05/2019.
//

import XCTest
@testable import Weather

final class CitiesAddRouterImplTests: XCTestCase {
    private var subject: CitiesAddRouterImpl!
    private var transitionable: TransitionableMock!
    
    override func setUp() {
        super.setUp()
        
        transitionable = .init()
        subject = CitiesAddRouterImpl(transitionable: transitionable)
    }
    
    func testCloseSearch() {
        subject.closeSearch()
        XCTAssertEqual(transitionable.dismissAnimatedCompletionCallsCount, 1)
        
        guard let args = transitionable.dismissAnimatedCompletionReceivedArgs else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(args.animated)
        XCTAssertNil(args.completion)
    }
    
    func testPresentError() {
        let expected = Constants.error
        subject.present(error: expected)
        XCTAssertEqual(transitionable.presentControllerAnimatedCompletionCallsCount, 1)
        
        guard let args = transitionable.presentControllerAnimatedCompletionReceivedArgs else {
            XCTFail()
            return
        }
        
        let controller = args.controller as? UIAlertController
        
        XCTAssert(controller, isKindOf: UIAlertController.self)
        XCTAssertEqual(controller?.title, "Error")
        XCTAssertEqual(controller?.message, expected.localizedDescription)
        XCTAssertEqual(controller?.preferredStyle, .alert)
        
        XCTAssertEqual(controller?.actions.count, 1)
        XCTAssertEqual(controller?.actions.first?.title, "OK")
        XCTAssertEqual(controller?.actions.first?.style, .default)
        
        XCTAssertTrue(args.animated)
        XCTAssertNil(args.completion)
    }
}
