//
//  Created by Dmitriy Stupivtsev on 02/05/2019.
//

import XCTest
@testable import Weather

final class FontTests: XCTestCase {
    func testFonts() {
        expect(actual: Font.regular11, equalTo: .init(size: 11, weight: .regular))
        expect(actual: Font.regular15, equalTo: .init(size: 15, weight: .regular))
        expect(actual: Font.regular17, equalTo: .init(size: 17, weight: .regular))
        expect(actual: Font.regular30, equalTo: .init(size: 30, weight: .regular))
        expect(actual: Font.regular90, equalTo: .init(size: 90, weight: .regular))
        
        var size: CGFloat = 1
        expect(actual: Font.regular(ofSize: size), equalTo: .init(size: size, weight: .regular))
        size = 19
        expect(actual: Font.regular(ofSize: size), equalTo: .init(size: size, weight: .regular))
        size = 20
        expect(actual: Font.regular(ofSize: size), equalTo: .init(size: size, weight: .regular))
        size = 100
        expect(actual: Font.regular(ofSize: size), equalTo: .init(size: size, weight: .regular))
        size = 1000
        expect(actual: Font.regular(ofSize: size), equalTo: .init(size: size, weight: .regular))
    }
    
    private func expect(actual: UIFont, equalTo components: FontComponents) {
        let actualComps = actual.components
        XCTAssertEqual(actualComps, components, "expect components to be \(components), got \(actualComps)")
    }
}

private extension UIFont {
    var components: FontComponents {
        let nameParts = fontName.split(separator: "-")
        
        return FontComponents(
            size: pointSize,
            weight: parse(weightName: nameParts.last.map(String.init))
        )
    }
    
    private func parse(weightName: String?) -> Weight {
        switch weightName ?? "" {
        case "UltraLight":
            return .ultraLight
            
        case "Thin":
            return .thin
            
        case "Light":
            return .light
            
        case "Regular":
            return .regular
            
        case "Medium":
            return .medium
            
        case "Semibold":
            return .semibold
            
        case "Bold":
            return .bold
            
        case "Heavy":
            return .heavy
            
        case "Black":
            return .black
            
        default:
            return .regular
        }
    }
}

private struct FontComponents: Equatable, CustomDebugStringConvertible {
    let size: CGFloat
    let weight: UIFont.Weight
    
    var debugDescription: String {
        return "size: \(size), weight: \(weight)"
    }
}
