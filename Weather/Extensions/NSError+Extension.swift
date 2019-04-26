//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

extension NSError {
    static var common: NSError {
        return NSError(domain: "Test", code: -1, userInfo: [NSLocalizedDescriptionKey: "Не удалось загрузить данные"])
    }
}
