//
//  Created by Dmitriy Stupivtsev on 15/05/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class CitySearchViewModelImplTests: XCTestCase {
    private let filterString = "1234"
    
    private var subject: CitySearchViewModelImpl!
    private var store: Store<[CitySource]>!
    private var searchService: CitySearchServiceMock!
    private var citiesService: CitiesServiceMock!
    private var executor: CancellableExecutorMock!
    private var viewUpdatable: CitySearchViewUpdatableMock!
    private var router: CitySearchRouterMock!
    
    override func setUp() {
        super.setUp()
        
        store = .init(state: [])
        searchService = .init()
        citiesService = .init()
        executor = .init()
        viewUpdatable = .init()
        router = .init()
        subject = CitySearchViewModelImpl(
            store: store,
            searchService: searchService,
            citiesService: citiesService,
            executor: executor,
            viewUpdatable: viewUpdatable,
            router: router
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
        searchService.getCitiesForLimitReturnValue = Promise(TestData.expectedModels)
        citiesService.getCitiesWeatherForReturnValue = Promise(TestData.expectedCitiesSources)
        
        subject.didChangeText(filterString)
        
        XCTAssertEqual(executor.executeHandlerCallsCount, 1)
        executor.executeHandlerReceivedHandler?(NotCancelled())
        
        XCTAssertEqual(searchService.getCitiesForLimitCallsCount, 1)
        XCTAssertEqual(searchService.getCitiesForLimitReceivedArgs?.name, filterString)
        XCTAssertEqual(searchService.getCitiesForLimitReceivedArgs?.limit, 50)
        
        XCTAssert(waitForPromises(timeout: 1))

        let indexPath = IndexPath(row: 0, section: 0)
        subject.select(at: indexPath)
        XCTAssertEqual(citiesService.getCitiesWeatherForCallsCount, 1)
        XCTAssertEqual(
            citiesService.getCitiesWeatherForReceivedCitiesIds,
            [TestData.expectedModels[indexPath.row].id].map(String.init)
        )
        
        XCTAssert(waitForPromises(timeout: 1))
        
        let receivedModels = viewUpdatable.updateProviderConvertiblesReceivedProviderConvertibles as? [CitySearchCell.Model]
        XCTAssertEqual(viewUpdatable.updateProviderConvertiblesCallsCount, 1)
        XCTAssertEqual(receivedModels, TestData.expectedCellModels)
        
        XCTAssertEqual(router.closeCallsCount, 1)
        XCTAssertEqual(store.state, TestData.expectedCitiesSources)
        
        subject.select(at: indexPath)
        XCTAssertEqual(router.openAlreadyAddedAlertCallsCount, 1)
        
        // TODO: Check failed result
    }
    
    func testDidChangeTextFailure() {
        let expectedError = Constants.error
        searchService.getCitiesForLimitReturnValue = Promise(expectedError)
        
        subject.didChangeText(filterString)
        
        XCTAssertEqual(executor.executeHandlerCallsCount, 1)
        executor.executeHandlerReceivedHandler?(NotCancelled())
        
        XCTAssertEqual(searchService.getCitiesForLimitCallsCount, 1)
        XCTAssertEqual(searchService.getCitiesForLimitReceivedArgs?.name, filterString)
        XCTAssertEqual(searchService.getCitiesForLimitReceivedArgs?.limit, 50)
        
        XCTAssert(waitForPromises(timeout: 1))
        
        XCTAssertEqual(viewUpdatable.updateProviderConvertiblesCallsCount, 1)
        XCTAssertEmpty(viewUpdatable.updateProviderConvertiblesReceivedProviderConvertibles)
    }
    
    func testDidChangeTextCancelled() {
        searchService.getCitiesForLimitReturnValue = Promise(TestData.expectedModels)
        
        subject.didChangeText(filterString)
        
        XCTAssertEqual(executor.executeHandlerCallsCount, 1)
        executor.executeHandlerReceivedHandler?(Cancelled())
        
        XCTAssertEqual(searchService.getCitiesForLimitCallsCount, 1)
        XCTAssertEqual(searchService.getCitiesForLimitReceivedArgs?.name, filterString)
        XCTAssertEqual(searchService.getCitiesForLimitReceivedArgs?.limit, 50)
        
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
