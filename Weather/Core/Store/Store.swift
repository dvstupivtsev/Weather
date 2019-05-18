//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import Foundation

// TODO: - Tests
final class Store<StateType> {
    private(set) var state: StateType
    private lazy var subscribers = [AnyStoreSubscriber]()
    
    init(state: StateType) {
        self.state = state
    }
    
    func dispatch(action: AnyStoreAction) {
        guard let state = action._modify(state: state) as? StateType else { return }
        
        self.state = state
        notifySubscribers()
    }
    
    func subscribe(_ subscriber: AnyStoreSubscriber) {
        guard subscribers.contains(where: { $0 === subscriber }) == false else { return }
        
        subscribers.append(subscriber)
    }
    
    func unsubscribe(_ subscriber: AnyStoreSubscriber) {
        guard let index = subscribers.firstIndex(where: { $0 === subscriber }) else { return }
        
        subscribers.remove(at: index)
    }
    
    private func notifySubscribers() {
        subscribers.forEach { $0._update(state: state) }
    }
}
