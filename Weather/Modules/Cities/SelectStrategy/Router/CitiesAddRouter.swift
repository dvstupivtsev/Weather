//
//  Created by Dmitriy Stupivtsev on 20/05/2019.
//

import Foundation

// sourcery: AutoMockable
protocol CitiesAddRouter {
    func closeSearch()
    func present(error: Error)
}
