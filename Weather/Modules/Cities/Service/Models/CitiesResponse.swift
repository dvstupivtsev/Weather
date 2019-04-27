//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

struct CitiesResponse: Equatable {
    let data: [City]
}

extension CitiesResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case data = "list"
    }
}
