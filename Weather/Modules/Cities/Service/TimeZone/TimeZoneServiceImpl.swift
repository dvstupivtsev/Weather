//
//  Created by Dmitriy Stupivtsev on 03/05/2019.
//

import Foundation
import Promises
import CoreLocation
import Prelude

final class TimeZoneServiceImpl: TimeZoneService {
    func getTimeZones(from coordinates: [Coordinate]) -> Promise<[TimeZone]> {
        let timeZonePromises: [Promise<TimeZone>] = coordinates.map { coordinate in
            Promise(on: .global(qos: .userInteractive)) { fulfill, reject in
                let location = CLLocation(latitude: coordinate.lat, longitude: coordinate.lon)
                
                CLGeocoder().reverseGeocodeLocation(location) { placemars, _ in
                    (placemars?.first.flatMap(^\.timeZone) ?? .current) |> fulfill
                }
            }
        }
        
        return all(timeZonePromises)
    }
}
