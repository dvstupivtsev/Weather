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
}
