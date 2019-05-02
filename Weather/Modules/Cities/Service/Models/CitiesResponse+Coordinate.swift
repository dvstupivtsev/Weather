//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import Foundation

extension CitiesResponse {
    struct Coordinate: Codable, Equatable {
        let lat: Double
        let lon: Double
    }
}
