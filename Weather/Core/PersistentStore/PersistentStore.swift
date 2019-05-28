//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import Foundation

protocol PersistentStore {
    func save()
    func insert(_ keyValuePairsArray: [[String: Any]], for entityName: String)
}
