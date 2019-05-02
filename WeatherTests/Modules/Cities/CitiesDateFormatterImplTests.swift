//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import XCTest
@testable import Weather

class CitiesDateFormatterImplTests: XCTestCase {
    var subject: CitiesDateFormatterImpl!
    
    override func setUp() {
        super.setUp()
        
        subject = CitiesDateFormatterImpl()
    }
    
    func testStringFromDate() {
        let date = Date()
        expect(actual: date, isToday: true)
        
        let startOfDay = Calendar.current.startOfDay(for: date)
        expect(actual: startOfDay, isToday: true)
        
        let endOfDay: Date = {
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }()
        expect(actual: endOfDay, isToday: true)
        
        let startOfDayMinusSecond: Date = {
            var components = DateComponents()
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }()
        expect(actual: startOfDayMinusSecond, isToday: false)
        
        let endOfDayPlusSecond: Date = {
            var components = DateComponents()
            components.second = 1
            return Calendar.current.date(byAdding: components, to: endOfDay)!
        }()
        expect(actual: endOfDayPlusSecond, isToday: false)
    }
    
    private func expect(actual: Date, isToday: Bool) {
        let formatter = isToday ? DateFormatter.hhmma : .yyyymmddhhmma
        let formattedExpectedDate = formatter.string(from: actual)
        let formattedActualDate = subject.string(from: actual)
        XCTAssertEqual(
            formattedActualDate,
            formattedExpectedDate,
            "expect formatted date to be \(formattedExpectedDate), got \(formattedActualDate)"
        )
    }
}
