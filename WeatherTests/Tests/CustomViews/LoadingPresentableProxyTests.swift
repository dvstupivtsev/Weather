//
//  Created by Dmitriy Stupivtsev on 22/06/2019.
//

import XCTest
@testable import Weather

class LoadingPresentableProxyTests: XCTestCase {
    var subject: LoadingPresentableProxy!
    var wrapped: LoadingPresentableMock!
    
    override func setUp() {
        super.setUp()
        
        subject = LoadingPresentableProxy()
        
        wrapped = LoadingPresentableMock()
        subject.wrapped = wrapped
    }
    
    func testShowLoading() {
        subject.showLoading()
        XCTAssertEqual(wrapped.showLoadingCallsCount, 1)
    }
    
    func testHideLoading() {
        subject.hideLoading()
        XCTAssertEqual(wrapped.hideLoadingCallsCount, 1)
    }
}
