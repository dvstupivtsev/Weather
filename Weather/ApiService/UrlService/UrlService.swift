//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

// sourcery: AutoMockable
protocol UrlService {
    func dataTask(with url: URL, completion: @escaping ResultHandler<Data?>)
}
