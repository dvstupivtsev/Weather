//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import XCTest
@testable import Weather

final class ColorTests: XCTestCase {
    func testColors() {
        expect(actual: Color.clear, equalTo: ColorComponents(red: 0, green: 0, blue: 0, alpha: 0))
        expect(actual: Color.white, equalTo: ColorComponents(red: 1, green: 1, blue: 1, alpha: 1))
        expect(actual: Color.white70, equalTo: ColorComponents(red: 1, green: 1, blue: 1, alpha: 0.7))
        expect(actual: Color.black, equalTo: ColorComponents(red: 0, green: 0, blue: 0, alpha: 1))
        expect(actual: Color.black50, equalTo: ColorComponents(red: 0, green: 0, blue: 0, alpha: 0.5))
        expect(actual: Color.black10, equalTo: ColorComponents(red: 0, green: 0, blue: 0, alpha: 0.1))
        
        expect(actual: Color.bg1, nearTo: ColorComponents(red: 25/255.0, green: 125/255.0, blue: 200/255.0, alpha: 1))
        expect(actual: Color.bg2, nearTo: ColorComponents(red: 50/255.0, green: 140/255.0, blue: 200/255.0, alpha: 1))
        expect(actual: Color.bg3, nearTo: ColorComponents(red: 75/255.0, green: 150/255.0, blue: 200/255.0, alpha: 1))
        expect(actual: Color.bg4, nearTo: ColorComponents(red: 100/255.0, green: 160/255.0, blue: 200/255.0, alpha: 1))
        expect(actual: Color.bg5, nearTo: ColorComponents(red: 125/255.0, green: 170/255.0, blue: 200/255.0, alpha: 1))
    }
    
    private func expect(actual: UIColor, equalTo components: ColorComponents) {
        let actualComponents = actual.rgba
        XCTAssertEqual(actualComponents, components, "expect components equal to \(components), got \(actualComponents)")
    }
    
    private func expect(actual: UIColor, nearTo components: ColorComponents) {
        let accuracy: CGFloat = 0.000000001
        
        let actualComponents = actual.rgba
        XCTAssertEqual(actualComponents.red, components.red, accuracy: accuracy, "expect red component equal to \(components.red), got \(actualComponents.red)")
        XCTAssertEqual(actualComponents.green, components.green, accuracy: accuracy, "expect green component equal to \(components.green), got \(actualComponents.green)")
        XCTAssertEqual(actualComponents.blue, components.blue, accuracy: accuracy, "expect blue component equal to \(components.blue), got \(actualComponents.blue)")
        XCTAssertEqual(actualComponents.alpha, components.alpha, accuracy: accuracy, "expect alpha component equal to \(components.alpha), got \(actualComponents.alpha)")
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
        "red: \(red), green: \(green), blue: \(blue), alpha: \(alpha)"
    }
}
