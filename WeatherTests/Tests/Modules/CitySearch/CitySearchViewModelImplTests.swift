//
//  Created by Dmitriy Stupivtsev on 15/05/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class CitySearchViewModelImplTests: XCTestCase {
    private var subject: CitySearchViewModelImpl!
    private var viewUpdatable: CitySearchViewUpdatableMock!
    
    override func setUp() {
        super.setUp()
        
        viewUpdatable = .init()
        subject = CitySearchViewModelImpl(viewUpdatable: viewUpdatable)
    }

    func testTextEditingDelegate() {
        XCTAssertIdentical(subject.textEditingDelegate, to: subject!)
    }
    
    func testDidChangeTextSuccess() {
        subject.didChangeText("123")
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(viewUpdatable.updateProviderConvertiblesCallsCount, 1)
        XCTAssertEmpty(viewUpdatable.updateProviderConvertiblesReceivedProviderConvertibles)
    }
    
    func testDidChangeTextFailure() {
        subject.didChangeText("123")
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(viewUpdatable.updateProviderConvertiblesCallsCount, 1)
        XCTAssertEmpty(viewUpdatable.updateProviderConvertiblesReceivedProviderConvertibles)
    }
}
