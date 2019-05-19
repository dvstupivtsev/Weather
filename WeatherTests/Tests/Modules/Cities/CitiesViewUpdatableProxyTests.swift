//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import XCTest
@testable import Weather

final class CitiesViewUpdatableProxyTests: XCTestCase {
    func testUpdate() {
        let subject = CitiesViewUpdatableProxy()
        let wrapped = CitiesViewUpdatableMock()
        
        let viewSource = CitiesViewSource(cellProviderConvertibles: [])
        subject.update(viewSource: viewSource)
        XCTAssertNil(wrapped.updateViewSourceReceivedViewSource)
        XCTAssertEqual(wrapped.updateViewSourceCallsCount, 0)
        
        subject.wrapped = wrapped
        subject.update(viewSource: viewSource)
        XCTAssertNotNil(wrapped.updateViewSourceReceivedViewSource)
        XCTAssertEqual(wrapped.updateViewSourceCallsCount, 1)
    }
}
