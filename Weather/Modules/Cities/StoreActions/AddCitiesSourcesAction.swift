//
//  Created by Dmitriy Stupivtsev on 18/05/2019.
//

import Foundation

// TODO: - Tests
struct AddCitiesSourcesAction: StoreAction {
    typealias StateType = [CitySource]
    
    private let citisSources: StateType
    
    init(citisSources: StateType) {
        self.citisSources = citisSources
    }
    
    func modify(state: StateType) -> StateType {
        var state = state
        state.append(contentsOf: citisSources)
        
        return state
    }
}
