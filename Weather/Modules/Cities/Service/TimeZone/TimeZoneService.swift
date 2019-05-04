//
//  Created by Dmitriy Stupivtsev on 03/05/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol TimeZoneService {
    func getTimeZones(from coordinates: [Coordinate]) -> Promise<[TimeZone]>
}
