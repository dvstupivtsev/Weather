//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import Foundation

// sourcery: AutoMockable
protocol PersistentStore {
    func save()
    
    func insert(
        _ keyValuePairsArray: [[String: Any]],
        for entityName: String,
        completion: @escaping Action
    )
    
    func count(
        for entityName: String,
        completion: @escaping Handler<Int>
    )
    
    func keyValuePairs(
        for entityName: String,
        predicate: NSPredicate?,
        limit: Int,
        completion: @escaping Handler<[[String: Any]]>
    )
}
