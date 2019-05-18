//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation
import Promises

protocol CitiesViewModel {
    var cellSelectionBehavior: CellSelectionBehavior { get }
    
    // TODO: Rename
    func getData()
}
