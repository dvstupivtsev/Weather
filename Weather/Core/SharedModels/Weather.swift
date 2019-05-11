//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

struct Weather: Equatable {
    let description: String
    let icon: String
}

extension Weather: Codable {
    private enum CodingKeys: String, CodingKey {
        case description = "main"
        case icon
    }
}
