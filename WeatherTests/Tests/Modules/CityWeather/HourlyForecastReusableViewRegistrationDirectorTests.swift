//
//  Created by Dmitriy Stupivtsev on 13/05/2019.
//

import XCTest
@testable import Weather

final class HourlyForecastReusableViewRegistrationDirectorTests: XCTestCase {
    func testRegisterViews() {
        let subject = HourlyForecastReusableViewRegistrationDirector()
        let registrator = CollectionReusableViewRegistratorMock()
        
        subject.registerViews(using: registrator)
        XCTAssertEqual(registrator.registerTypeCallsCount, 1)
        
        let expectedValue = String(describing: HourlyForecastCollectionCell.self)
        XCTAssertEqual(String(describing: registrator.registerTypeReceivedType!), expectedValue)
    }
}
