//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import Foundation

extension Date {
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
