//
//  Created by Dmitriy Stupivtsev on 04/05/2019.
//

import XCTest
@testable import Weather

class CGSize_ExtensionTests: XCTestCase {
    func testInitEdgeCGFloat() {
        var value: CGFloat = 100
        compare(expected: CGSize(edge: value), received: CGSize(width: value, height: value))
        
        value = 11.234
        compare(expected: CGSize(edge: value), received: CGSize(width: value, height: value))
        
        value = 0
        compare(expected: CGSize(edge: value), received: CGSize(width: value, height: value))
        
        value = -23451.1234
        compare(expected: CGSize(edge: value), received: CGSize(width: value, height: value))
    }
    
    func testInitEdgeDouble() {
        var value: Double = 100
        compare(expected: CGSize(edge: value), received: CGSize(width: value, height: value))
        
        value = 11.234
        compare(expected: CGSize(edge: value), received: CGSize(width: value, height: value))
        
        value = 0
        compare(expected: CGSize(edge: value), received: CGSize(width: value, height: value))
        
        value = -23451.1234
        compare(expected: CGSize(edge: value), received: CGSize(width: value, height: value))
    }
    
    func testInitEdgeInt() {
        var value: Int = 100
        compare(expected: CGSize(edge: value), received: CGSize(width: value, height: value))
        
        value = 0
        compare(expected: CGSize(edge: value), received: CGSize(width: value, height: value))
        
        value = -23451
        compare(expected: CGSize(edge: value), received: CGSize(width: value, height: value))
    }
}
