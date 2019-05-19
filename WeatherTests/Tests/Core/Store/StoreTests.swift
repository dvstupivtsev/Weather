//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import XCTest
@testable import Weather

final class StoreTests: XCTestCase {
    private var subject: Store<Model>!
    
    override func setUp() {
        super.setUp()
        
        subject = Store<Model>(state: Model(int: 0, string: ""))
    }

    func testDispatch() {
        let subscriber1 = StoreSubscriberMock(id: 1)
        let subscriber2 = StoreSubscriberMock(id: 2)
        subject.subscribe(subscriber1)
        subject.subscribe(subscriber1)
        subject.subscribe(subscriber2)
        
        var newModel = Model(int: 42, string: subject.state.string)
        subject.dispatch(action: UpdateIntAction(newInt: newModel.int))
        XCTAssertEqual(subject.state, newModel)
        XCTAssertEqual(subscriber1.updateStateCallsCount, 1)
        XCTAssertEqual(subscriber2.updateStateCallsCount, 1)
        XCTAssertEqual(subscriber1.updateStateReceivedState, newModel)
        XCTAssertEqual(subscriber2.updateStateReceivedState, newModel)
        
        newModel = Model(int: newModel.int, string: "Test")
        subject.dispatch(action: UpdateStringAction(newString: newModel.string))
        XCTAssertEqual(subject.state, newModel)
        XCTAssertEqual(subscriber1.updateStateCallsCount, 2)
        XCTAssertEqual(subscriber2.updateStateCallsCount, 2)
        XCTAssertEqual(subscriber1.updateStateReceivedState, newModel)
        XCTAssertEqual(subscriber2.updateStateReceivedState, newModel)
        
        subject.unsubscribe(subscriber1)
        
        newModel = Model(int: 111, string: newModel.string)
        subject.dispatch(action: UpdateIntAction(newInt: newModel.int))
        XCTAssertEqual(subject.state, newModel)
        XCTAssertEqual(subscriber1.updateStateCallsCount, 2)
        XCTAssertEqual(subscriber2.updateStateCallsCount, 3)
        XCTAssertEqual(subscriber2.updateStateReceivedState, newModel)
        
        subject.unsubscribe(subscriber2)
        
        newModel = Model(int: 456, string: newModel.string)
        subject.dispatch(action: UpdateIntAction(newInt: newModel.int))
        XCTAssertEqual(subject.state, newModel)
        XCTAssertEqual(subscriber1.updateStateCallsCount, 2)
        XCTAssertEqual(subscriber2.updateStateCallsCount, 3)
    }
}

private extension StoreTests {
    struct Model: Equatable {
        let int: Int
        let string: String
    }
    
    struct UpdateIntAction: StoreAction {
        typealias StateType = Model
        
        let newInt: Int
        
        func modify(state: StoreTests.Model) -> StoreTests.Model {
            return Model(int: newInt, string: state.string)
        }
    }
    
    struct UpdateStringAction: StoreAction {
        typealias StateType = Model
        
        let newString: String
        
        func modify(state: StoreTests.Model) -> StoreTests.Model {
            return Model(int: state.int, string: newString)
        }
    }
    
    final class StoreSubscriberMock: StoreSubscriber {
        typealias StateType = Model
        
        let id: Int
        
        init(id: Int) {
            self.id = id
        }
        
        var updateStateReceivedState: StoreTests.Model!
        var updateStateCallsCount: Int = 0
        func update(state: StoreTests.Model) {
            updateStateReceivedState = state
            updateStateCallsCount += 1
        }
    }
}
