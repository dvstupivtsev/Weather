//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import XCTest
@testable import Weather

final class Date_ExtensionTests: XCTestCase {
    func testIsTooday() {
        let date = Date()
        let startOfDay = Calendar.current.startOfDay(for: date)
        
        XCTAssertTrue(startOfDay.isToday, "expect start of day should be true, got false")
        
        let endOfDay: Date = {
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }()
        XCTAssertTrue(endOfDay.isToday, "expect end of day should be true, got false")
        
        let startOfDayMinusSecond: Date = {
            var components = DateComponents()
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }()
        XCTAssertFalse(startOfDayMinusSecond.isToday, "expect start of day minus second should be false, got true")
        
        let endOfDayPlusSecond: Date = {
            var components = DateComponents()
            components.second = 1
            return Calendar.current.date(byAdding: components, to: endOfDay)!
        }()
        XCTAssertFalse(endOfDayPlusSecond.isToday, "expect end of day plus second should be false, got true")
    }
}
