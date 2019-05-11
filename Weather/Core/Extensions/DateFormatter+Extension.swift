//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import Foundation

// sourcery: AutoMockable
protocol DateFormatterProtocol {
    func string(from: Date) -> String
}

extension DateFormatter: DateFormatterProtocol { }

extension DateFormatter {
    // 06:47 PM
    static let hh_mm_a = make(object: DateFormatter()) {
        $0.locale = Locale(identifier: "en_US")
        $0.timeZone = TimeZone(secondsFromGMT: 0)
        $0.dateFormat = "hh:mm a"
    }
    
    // 05/02/2019 06:47 PM
    static let MM_dd_yyyy_hh_mm_a = make(object: DateFormatter()) {
        $0.locale = Locale(identifier: "en_US")
        $0.timeZone = TimeZone(secondsFromGMT: 0)
        $0.dateFormat = "MM/dd/yyyy hh:mm a"
    }
    
    // Saturday, May 11
    static let EEEE_MMM_dd = make(object: DateFormatter()) {
        $0.locale = Locale(identifier: "en_US")
        $0.timeZone = TimeZone(secondsFromGMT: 0)
        $0.dateFormat = "EEEE, MMM dd"
    }
}
