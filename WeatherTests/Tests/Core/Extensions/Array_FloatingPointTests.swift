//
//  Created by Dmitriy Stupivtsev on 28/04/2019.
//

import XCTest
@testable import Weather

final class Array_FloatingPointTests: XCTestCase {
    func testAverageFloat() {
        var array = [Float]()
        XCTAssertEqual(array.average(), 0)
        
        array = [1]
        XCTAssertEqual(array.average(), 1)
        
        array = [1, 2]
        XCTAssertEqual(array.average(), 1.5)
        
        array = [13, 7]
        XCTAssertEqual(array.average(), 10)
        
        array = [13, 7, 21, 3]
        XCTAssertEqual(array.average(), 11)
        
        array = [13.1, 14.6, 17.890, 0.01]
        XCTAssertEqual(array.average(), 11.4)
    }
    
    func testAverageDouble() {
        var array = [Double]()
        XCTAssertEqual(array.average(), 0)
        
        array = [1]
        XCTAssertEqual(array.average(), 1)
        
        array = [1, 2]
        XCTAssertEqual(array.average(), 1.5)
        
        array = [13, 7]
        XCTAssertEqual(array.average(), 10)
        
        array = [13, 7, 21, 3]
        XCTAssertEqual(array.average(), 11)
        
        array = [13.1, 14.6, 17.890, 0.01]
        XCTAssertEqual(array.average(), 11.4)
    }
}
