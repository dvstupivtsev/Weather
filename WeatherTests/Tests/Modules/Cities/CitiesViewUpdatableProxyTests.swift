//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import XCTest
@testable import Weather

final class CitiesViewUpdatableProxyTests: XCTestCase {
    var subject: CitiesViewUpdatableProxy!
    var wrapped: CitiesViewUpdatableMock!
    
    override func setUp() {
        super.setUp()
        
        subject = CitiesViewUpdatableProxy()
        
        wrapped = CitiesViewUpdatableMock()
        subject.wrapped = wrapped
    }
    
    func testUpdate() {
        let viewSource = CitiesViewSource(cellProviderConvertibles: [])
        subject.update(viewSource: viewSource)
        XCTAssertNotNil(wrapped.updateViewSourceReceivedViewSource)
        XCTAssertEqual(wrapped.updateViewSourceCallsCount, 1)
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
