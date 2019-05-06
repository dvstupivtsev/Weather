//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

// TODO: - Rename
struct CitiesResponse: Equatable {
    // TODO: - Rename
    let cities: [City]
}

extension CitiesResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case cities = "list"
    }
}
