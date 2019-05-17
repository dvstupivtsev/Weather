//
//  Created by Dmitriy Stupivtsev on 17/05/2019.
//

import XCTest
@testable import Weather

final class CitySearchReusableViewRegistrationDirectorTests: XCTestCase {
    func testRegisterViews() {
        let subject = CitySearchReusableViewRegistrationDirector()
        let registrator = TableReusableViewRegistratorMock()
        
        let expectedValue = [CitySearchCell.self]
            .map(String.init(describing:))
        
        var types = [UITableViewCell.Type]()
        registrator.registerTypeClosure = { types.append($0) }
        
        subject.registerViews(using: registrator)
        XCTAssertEqual(registrator.registerTypeCallsCount, expectedValue.count)
        
        XCTAssertEqual(types.map(String.init(describing:)), expectedValue)
    }
}
