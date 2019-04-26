//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

// sourcery: AutoMockable
protocol ApiService {
    func execute(request: ApiServiceRequest, completion: @escaping ResultHandler<Data?>)
}
