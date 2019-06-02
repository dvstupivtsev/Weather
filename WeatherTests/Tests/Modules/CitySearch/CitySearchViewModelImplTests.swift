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
    private var executor: CancellableExecutorMock!
    private var viewUpdatable: CitySearchViewUpdatableMock!
    private var router: CitySearchRouterMock!
    private var selectStrategy: CitySearchSelectStrategyMock!
    
    override func setUp() {
        super.setUp()
        
        service = .init()
        executor = .init()
        viewUpdatable = .init()
        router = .init()
        selectStrategy = .init()
        subject = CitySearchViewModelImpl(
            service: service,
            executor: executor,
            viewUpdatable: viewUpdatable,
            router: router,
            selectStrategy: selectStrategy
        )
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
    
    func testDidChangeTextSuccess() {
        let expectedModels = TestData.expectedModels
        service.getCitiesForLimitReturnValue = Promise(expectedModels)
        
        subject.didChangeText(filterString)
        
        XCTAssertEqual(executor.executeDelayHandlerCallsCount, 1)
        XCTAssertEqual(executor.executeDelayHandlerReceivedArgs?.delay, 200)
        executor.executeDelayHandlerReceivedArgs?.handler(NotCancelled())
        
        XCTAssertEqual(service.getCitiesForLimitCallsCount, 1)
        XCTAssertEqual(service.getCitiesForLimitReceivedArgs?.name, filterString)
        XCTAssertEqual(service.getCitiesForLimitReceivedArgs?.limit, 50)
        
        XCTAssert(waitForPromises(timeout: 1))

        let indexPath = IndexPath(row: 0, section: 0)
        subject.select(at: indexPath)
        XCTAssertEqual(selectStrategy.selectCityModelReceivedCityModel, expectedModels[0])
        XCTAssertEqual(selectStrategy.selectCityModelCallsCount, 1)
        
        // TODO: Check failed result
    }
    
    func testDidChangeTextFailure() {
        let expectedError = Constants.error
        service.getCitiesForLimitReturnValue = Promise(expectedError)
        
        subject.didChangeText(filterString)
        
        XCTAssertEqual(executor.executeDelayHandlerCallsCount, 1)
        XCTAssertEqual(executor.executeDelayHandlerReceivedArgs?.delay, 200)
        executor.executeDelayHandlerReceivedArgs?.handler(NotCancelled())
        
        XCTAssertEqual(service.getCitiesForLimitCallsCount, 1)
        XCTAssertEqual(service.getCitiesForLimitReceivedArgs?.name, filterString)
        XCTAssertEqual(service.getCitiesForLimitReceivedArgs?.limit, 50)
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(viewUpdatable.updateProviderConvertiblesCallsCount, 1)
        XCTAssertEmpty(viewUpdatable.updateProviderConvertiblesReceivedProviderConvertibles)
    }
    
    func testDidChangeTextCancelled() {
        service.getCitiesForLimitReturnValue = Promise(TestData.expectedModels)
        
        subject.didChangeText(filterString)
        
        XCTAssertEqual(executor.executeDelayHandlerCallsCount, 1)
        XCTAssertEqual(executor.executeDelayHandlerReceivedArgs?.delay, 200)
        executor.executeDelayHandlerReceivedArgs?.handler(Cancelled())
        
        XCTAssertEqual(service.getCitiesForLimitCallsCount, 1)
        XCTAssertEqual(service.getCitiesForLimitReceivedArgs?.name, filterString)
        XCTAssertEqual(service.getCitiesForLimitReceivedArgs?.limit, 50)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(viewUpdatable.updateProviderConvertiblesCallsCount, 0)
    }
    
    func testClose() {
        subject.close()
        XCTAssertEqual(router.closeCallsCount, 1)
    }
}

private extension CitySearchViewModelImplTests {
    struct TestData {
        static let expectedModels = [CityModel.model1, .model2, .model3]
        static let expectedCellModels = expectedModels.map {
            CitySearchCell.Model(title: "\($0.name), \($0.country)")
        }
        static let expectedCitiesSources = [
            CitySource(city: .city1, timeZone: .current),
            CitySource(city: .city2, timeZone: .current)
        ]
    }
}

extension CitySearchCell.Model: Equatable {
    public static func == (lhs: CitySearchCell.Model, rhs: CitySearchCell.Model) -> Bool {
        return lhs.title == rhs.title
    }
}
