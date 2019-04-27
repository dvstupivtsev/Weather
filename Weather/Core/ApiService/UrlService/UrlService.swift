//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation
import Promises

// sourcery: AutoMockable
protocol UrlService {
    func dataTask(with url: URL) -> Promise<Data?>
}
