//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

struct CitiesResponse: Equatable {
    let cities: [City]
}

extension CitiesResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case cities = "list"
    }
}
