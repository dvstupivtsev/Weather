//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import Foundation

extension DateFormatter {
    // 06:47 PM
    static let hhmma = make(object: DateFormatter()) {
        $0.dateFormat = "hh:mm a"
    }
    
    // 2019:05:02 06:47 PM
    static let yyyymmddhhmma = make(object: DateFormatter()) {
        $0.dateFormat = "MM/dd/yyyy hh:mm a"
    }
}
