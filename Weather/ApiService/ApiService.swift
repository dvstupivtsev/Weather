//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol ApiService {
    func execute(request: ApiServiceRequest) -> Promise<Data?>
}
