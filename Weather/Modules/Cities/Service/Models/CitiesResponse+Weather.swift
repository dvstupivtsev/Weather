//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

extension CitiesResponse {
    struct Weather: Equatable {
        let icon: String
        let description: String
    }
}

extension CitiesResponse.Weather: Codable {
    private enum CodingKeys: String, CodingKey {
        case icon
        case description = "main"
    }
}
