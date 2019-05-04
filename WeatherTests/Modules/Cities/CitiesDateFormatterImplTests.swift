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
        expect(actual: date, timeZone: TimeZone(secondsFromGMT: 24352)!, isToday: true)
        
        let startOfDay = Calendar.current.startOfDay(for: date)
        expect(actual: startOfDay, timeZone: TimeZone(secondsFromGMT: 1234)!, isToday: true)
        
        let endOfDay: Date = {
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }()
        expect(actual: endOfDay, timeZone: TimeZone(secondsFromGMT: 6543)!, isToday: true)
        
        let startOfDayMinusSecond: Date = {
            var components = DateComponents()
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }()
        expect(actual: startOfDayMinusSecond, timeZone: TimeZone(secondsFromGMT: 456)!, isToday: false)
        
        let endOfDayPlusSecond: Date = {
            var components = DateComponents()
            components.second = 1
            return Calendar.current.date(byAdding: components, to: endOfDay)!
        }()
        expect(actual: endOfDayPlusSecond, timeZone: TimeZone(secondsFromGMT: 346)!, isToday: false)
    }
    
    private func expect(actual: Date, timeZone: TimeZone, isToday: Bool) {
        let formatter = isToday ? DateFormatter.hhmma : .yyyymmddhhmma
        formatter.timeZone = timeZone
        let formattedExpectedDate = formatter.string(from: actual)
        let formattedActualDate = subject.string(from: actual, timeZone: timeZone)
        XCTAssertEqual(
            formattedActualDate,
            formattedExpectedDate,
            "expect formatted date to be \(formattedExpectedDate), got \(formattedActualDate)"
        )
    }
}
