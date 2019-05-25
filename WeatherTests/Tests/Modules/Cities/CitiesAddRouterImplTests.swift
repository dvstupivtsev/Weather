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
}
