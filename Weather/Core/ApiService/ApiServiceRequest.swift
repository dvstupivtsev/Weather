//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

struct ApiServiceRequest: Equatable {
    let name: String
    let parameters: [String: String]
}
