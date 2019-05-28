//
//  Created by Dmitriy Stupivtsev on 28/05/2019.
//

import Foundation
import CoreData

protocol ManagedObjectContextContainer {
    var context: NSManagedObjectContext? { get }
}
