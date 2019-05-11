//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import Foundation

final class CitiesDateFormatterImpl: CitiesDateFormatter {
    func string(from date: Date, timeZone: TimeZone) -> String {
        let formatter: DateFormatter
        if date.isToday {
            formatter = DateFormatter.hh_mm_a
        } else {
            formatter = DateFormatter.MM_dd_yyyy_hh_mm_a
        }
        
        let oldTimeZone = formatter.timeZone
        formatter.timeZone = timeZone
        let dateString = formatter.string(from: date)
        formatter.timeZone = oldTimeZone
        
        return dateString
    }
}
