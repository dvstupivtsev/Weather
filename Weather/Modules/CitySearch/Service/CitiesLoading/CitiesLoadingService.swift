//
//  Created by Dmitriy Stupivtsev on 16/05/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol CitiesLoadingService {
    func loadCities() -> Promise<Void>
}
