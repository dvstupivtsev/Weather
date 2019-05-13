//
//  Created by Dmitriy Stupivtsev on 13/05/2019.
//

import XCTest
@testable import Weather

final class CitiesReusableViewRegistrationDirectorTests: XCTestCase {
    func testRegisterViews() {
        let subject = CitiesReusableViewRegistrationDirector()
        let registrator = TableReusableViewRegistratorMock()
        
        let expectedValue = [CityCell.self, CitiesHeaderCell.self]
            .map(String.init(describing:))
        
        var types = [UITableViewCell.Type]()
        registrator.registerTypeClosure = { types.append($0) }
        
        subject.registerViews(using: registrator)
        XCTAssertEqual(registrator.registerTypeCallsCount, expectedValue.count)
        
        XCTAssertEqual(types.map(String.init(describing:)), expectedValue)
    }
}
