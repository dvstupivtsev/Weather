//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import XCTest
@testable import Weather

final class ColorTests: XCTestCase {
    func testColors() {
        expect(actual: Color.black, equalTo: ColorComponents(red: 0, green: 0, blue: 0, alpha: 1))
        expect(actual: Color.black50, equalTo: ColorComponents(red: 0, green: 0, blue: 0, alpha: 0.5))
    }
    
    private func expect(actual: UIColor, equalTo components: ColorComponents) {
        let actualComponents = actual.rgba
        XCTAssertEqual(actualComponents, components, "expect components equal to \(components), got \(actualComponents)")
    }
}

private extension UIColor {
    var rgba: ColorComponents {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return ColorComponents(red: red, green: green, blue: blue, alpha: alpha)
    }
}

private struct ColorComponents: Equatable, CustomDebugStringConvertible {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat
    
    var debugDescription: String {
        return "red: \(red), green: \(green), blue: \(blue), alpha: \(alpha)"
    }
}
