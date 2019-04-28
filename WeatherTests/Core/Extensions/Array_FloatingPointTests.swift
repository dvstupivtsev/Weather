//
//  Created by Dmitriy Stupivtsev on 28/04/2019.
//

import XCTest
@testable import Weather

final class Array_FloatingPointTests: XCTestCase {
    func testAverageFloat() {
        var array = [Float]()
        compare(expected: 0, received: array.average())
        
        array = [1]
        compare(expected: 1, received: array.average())
        
        array = [1, 2]
        compare(expected: 1.5, received: array.average())
        
        array = [13, 7]
        compare(expected: 10, received: array.average())
        
        array = [13, 7, 21, 3]
        compare(expected: 11, received: array.average())
        
        array = [13.1, 14.6, 17.890, 0.01]
        compare(expected: 11.4, received: array.average())
    }
    
    func testAverageDouble() {
        var array = [Double]()
        
        array = [1]
        compare(expected: 1, received: array.average())
        
        array = [1, 2]
        compare(expected: 1.5, received: array.average())
        
        array = [13, 7]
        compare(expected: 10, received: array.average())
        
        array = [13, 7, 21, 3]
        compare(expected: 11, received: array.average())
        
        array = [13.1, 14.6, 17.890, 0.01]
        compare(expected: 11.4, received: array.average())
        
    }
}
