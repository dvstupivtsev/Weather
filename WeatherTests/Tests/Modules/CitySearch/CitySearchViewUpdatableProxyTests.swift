//
//  Created by Dmitriy Stupivtsev on 15/05/2019.
//

import XCTest
@testable import Weather

final class CitySearchViewUpdatableProxyTests: XCTestCase {
    func testUpdateProviderConvertibles() {
        let viewUpdatable = CitySearchViewUpdatableMock()
        let subject = CitySearchViewUpdatableProxy()
        
        let expectedValue = [TableCellProviderConvertibleMock(id: 1), .init(id: 2)]
        subject.update(providerConvertibles: expectedValue)
        XCTAssertEqual(viewUpdatable.updateProviderConvertiblesCallsCount, 0)
        
        subject.wrapped = viewUpdatable
        subject.update(providerConvertibles: expectedValue)
        XCTAssertEqual(viewUpdatable.updateProviderConvertiblesCallsCount, 1)
        XCTAssertEqual(
            viewUpdatable.updateProviderConvertiblesReceivedProviderConvertibles as? [TableCellProviderConvertibleMock],
            expectedValue
        )
    }
}
