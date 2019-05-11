//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

extension City {
    struct Weather: Equatable {
        let icon: String
    }
}

extension City.Weather: Codable {
    private enum CodingKeys: String, CodingKey {
        case icon
    }
}
