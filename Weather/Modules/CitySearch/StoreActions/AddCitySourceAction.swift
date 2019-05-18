//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import Foundation

// TODO: - Tests
struct AddCitySourceAction: StoreAction {
    typealias StateType = [CitySource]
    
    private let citySource: StateType.Element
    
    init(citySource: StateType.Element) {
        self.citySource = citySource
    }
    
    func modify(state: StateType) -> StateType {
        var state = state
        state.append(citySource)
        
        return state
    }
}
