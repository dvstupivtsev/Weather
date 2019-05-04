//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import Foundation

// sourcery: AutoMockable
protocol CitiesDateFormatter {
    func string(from date: Date, timeZone: TimeZone) -> String
}
