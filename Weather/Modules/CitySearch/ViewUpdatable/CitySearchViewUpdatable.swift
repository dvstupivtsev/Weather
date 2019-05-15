//
//  Created by Dmitriy Stupivtsev on 15/05/2019.
//

import Foundation

// sourcery: AutoMockable
protocol CitySearchViewUpdatable: AnyObject {
    func update(providerConvertibles: [CellProviderConvertible])
}
