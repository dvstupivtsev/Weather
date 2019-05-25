//
//  Created by Dmitriy Stupivtsev on 19/05/2019.
//

import Foundation

struct PersistentStoreFactory {
    func createCoreDataStore() -> PersistentStore {
        return CoreDataStore(
            containerName: "WeatherPersistentContainer",
            modelName: "WeatherDataModel"
        )
    }
}
