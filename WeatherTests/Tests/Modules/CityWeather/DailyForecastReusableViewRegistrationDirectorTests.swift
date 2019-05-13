//
//  Created by Dmitriy Stupivtsev on 13/05/2019.
//

import XCTest
@testable import Weather

final class DailyForecastReusableViewRegistrationDirectorTests: XCTestCase {
    func testRegisterViews() {
        let subject = DailyForecastReusableViewRegistrationDirector()
        let registrator = TableReusableViewRegistratorMock()
        
        subject.registerViews(using: registrator)
        XCTAssertEqual(registrator.registerTypeCallsCount, 1)
        
        let expectedValue = String(describing: DailyForecastCell.self)
        XCTAssertEqual(String(describing: registrator.registerTypeReceivedType!), expectedValue)
    }
}
