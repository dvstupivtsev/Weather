//
//  Created by Dmitriy Stupivtsev on 28/04/2019.
//

import XCTest

func compare<Type: Equatable>(expected: Type, received: Type) {
    XCTAssert(received == expected, "expected value is \(expected), got \(received)")
}
