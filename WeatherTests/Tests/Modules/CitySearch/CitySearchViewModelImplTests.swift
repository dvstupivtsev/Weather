//
//  Created by Dmitriy Stupivtsev on 15/05/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class CitySearchViewModelImplTests: XCTestCase {
    private let filterString = "1234"
    
    private var subject: CitySearchViewModelImpl!
    private var service: CitySearchServiceMock!
    private var viewUpdatable: CitySearchViewUpdatableMock!
    
    override func setUp() {
        super.setUp()
        
        service = .init()
        viewUpdatable = .init()
        subject = CitySearchViewModelImpl(service: service, viewUpdatable: viewUpdatable)
    }

    func testTextEditingDelegate() {
        XCTAssertIdentical(subject.textEditingDelegate, to: subject!)
    }
    
    func testSelectionBehavior() {
        XCTAssertIdentical(subject.selectionBehavior, to: subject!)
    }
    
    func testCanSelect() {
        XCTAssertTrue(subject.shouldSelect(at: IndexPath(row: 0, section: 0)))
        XCTAssertTrue(subject.shouldSelect(at: IndexPath(row: 1, section: 0)))
        XCTAssertTrue(subject.shouldSelect(at: IndexPath(row: 1, section: 234)))
        XCTAssertTrue(subject.shouldSelect(at: IndexPath(row: 999, section: 43)))
    }
    
    func testSelect() {
        // TODO: Tests
    }
    
    func testDidChangeTextSuccess() {
        service.getCitiesForReturnValue = Promise(TestData.expectedModels)
        
        subject.didChangeText(filterString)
        
        XCTAssertEqual(service.getCitiesForCallsCount, 1)
        XCTAssertEqual(service.getCitiesForReceivedName, filterString)
        
        XCTAssert(waitForPromises(timeout: 1))
        
        let receivedModels = viewUpdatable.updateProviderConvertiblesReceivedProviderConvertibles as? [CitySearchCell.Model]
        XCTAssertEqual(viewUpdatable.updateProviderConvertiblesCallsCount, 1)
        XCTAssertEqual(receivedModels, TestData.expectedCellModels)
    }
    
    func testDidChangeTextWithTooShortFilterString() {
        subject.didChangeText("12")
        
        XCTAssertEqual(service.getCitiesForCallsCount, 0)
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(viewUpdatable.updateProviderConvertiblesCallsCount, 1)
        XCTAssertEmpty(viewUpdatable.updateProviderConvertiblesReceivedProviderConvertibles)
    }
    
    func testDidChangeTextFailure() {
        let expectedError = Constants.error
        service.getCitiesForReturnValue = Promise(expectedError)
        
        subject.didChangeText(filterString)
        
        XCTAssertEqual(service.getCitiesForCallsCount, 1)
        XCTAssertEqual(service.getCitiesForReceivedName, filterString)
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(viewUpdatable.updateProviderConvertiblesCallsCount, 1)
        XCTAssertEmpty(viewUpdatable.updateProviderConvertiblesReceivedProviderConvertibles)
    }
}

private extension CitySearchViewModelImplTests {
    struct TestData {
        static let expectedModels = [CityModel.model1, .model2, .model3]
        static let expectedCellModels = expectedModels.map {
            CitySearchCell.Model(title: "\($0.name), \($0.country)")
        }
    }
}

extension CitySearchCell.Model: Equatable {
    public static func == (lhs: CitySearchCell.Model, rhs: CitySearchCell.Model) -> Bool {
        return lhs.title == rhs.title
    }
}
