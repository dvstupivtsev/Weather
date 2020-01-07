//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

extension NSError {
    static var common: NSError {
        NSError(domain: "Test", code: -1, userInfo: [NSLocalizedDescriptionKey: "Data loading failed"])
    }
    
    static func error(message: String) -> NSError {
        NSError(domain: "Test", code: -1, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
