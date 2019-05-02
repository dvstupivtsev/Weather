//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import Foundation

final class CitiesDateFormatterImpl: CitiesDateFormatter {
    func string(from date: Date) -> String {
        let dateString: String
        
        if date.isToday {
            dateString = DateFormatter.hhmma.string(from: date)
        } else {
            dateString = DateFormatter.yyyymmddhhmma.string(from: date)
        }
        
        return dateString
    }
}
