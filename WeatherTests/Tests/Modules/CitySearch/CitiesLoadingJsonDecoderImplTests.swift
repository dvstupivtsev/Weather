//
//  Created by Dmitriy Stupivtsev on 16/05/2019.
//

import XCTest
@testable import Weather

final class CitiesLoadingJsonDecoderImplTests: XCTestCase {
    private var subject: CitiesLoadingJsonDecoderImpl!
    
    override func setUp() {
        super.setUp()
        
        subject = CitiesLoadingJsonDecoderImpl()
    }
    
    func testParseDataWithValidJson() {
        let receivedModels: [CityModel] = try! subject.parse(data: validJson)

        XCTAssertEqual(receivedModels, expectedModels)
    }
    
    func testParseDataWithInvalidJson() {
        var parseError: Error?
        do {
            let _: [CityModel] = try subject.parse(data: invalidJson)
        } catch {
            parseError = error
        }

        XCTAssertNotNil(parseError)
    }
}

private extension CitiesLoadingJsonDecoderImplTests {
    var expectedModels: [CityModel] {
        [.model1, .model2, .model3]
    }

    var validJson: Data {
        try! JSONEncoder().encode(expectedModels)
    }

    var invalidJson: Data {
        Data()
    }
}
