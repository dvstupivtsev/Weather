//
//  Created by Dmitriy Stupivtsev on 15/05/2019.
//

import Foundation

final class CitySearchViewUpdatableProxy: CitySearchViewUpdatable {
    weak var wrapped: CitySearchViewUpdatable?
    
    func update(providerConvertibles: [CellProviderConvertible]) {
        wrapped?.update(providerConvertibles: providerConvertibles)
    }
}
