//
//  Created by Dmitriy Stupivtsev on 13/05/2019.
//

import Foundation
import Promises

protocol CitySearchViewModel {
    var textEditingDelegate: TextEditingDelegate { get }
    var selectionBehavior: CellSelectionBehavior { get }
    
    func close()
}
