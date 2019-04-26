//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

struct CitiesListResponse {
    let data: [City]
}

extension CitiesListResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case data = "list"
    }
}
