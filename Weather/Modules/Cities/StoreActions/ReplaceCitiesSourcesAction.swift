//
//  Created by Dmitriy Stupivtsev on 09/06/2019.
//

import Foundation

struct ReplaceCitiesSourcesAction: StoreAction {
    typealias StateType = [CitySource]
    
    private let citisSources: StateType
    
    init(citisSources: StateType) {
        self.citisSources = citisSources
    }
    
    func modify(state: StateType) -> StateType {
        var state = state
        state.removeAll()
        state.append(contentsOf: citisSources)
        
        return state
    }
}
