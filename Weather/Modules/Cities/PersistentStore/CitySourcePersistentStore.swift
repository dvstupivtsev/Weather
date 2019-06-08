//
//  Created by Dmitriy Stupivtsev on 03/06/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol CitySourcePersistentStore {
    func insert(cities: [CitySource]) -> Promise<Void>
    func cities() -> Promise<[CitySource]>
}
