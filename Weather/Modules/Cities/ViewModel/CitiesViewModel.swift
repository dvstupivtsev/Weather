//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation
import Promises

protocol CitiesViewModel {
    func getData() -> Promise<CitiesViewSource>
}
