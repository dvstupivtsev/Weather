//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import XCTest
@testable import Weather

final class CitiesWeatherJsonDecoderImplTests: XCTestCase {
    private var subject: CitiesWeatherJsonDecoderImpl!
    override func setUp() {
        super.setUp()
        
        subject = CitiesWeatherJsonDecoderImpl()
    }

    func testParseDataWithValidJson() {
        let response: CitiesResponse = try! subject.parse(data: validJson)
        let cities: [City] = try! subject.parse(data: validJson)
        
        XCTAssertEqual(response, expectedResponse)
        XCTAssertEqual(cities, expectedCities)
    }
    
    func testParseDataWithInvalidJson() {
        var parseError: Error?
        do {
            let _: CitiesResponse = try subject.parse(data: invalidJson)
        } catch {
            parseError = error
        }
        
        XCTAssertNotNil(parseError)
        
        do {
            let _: [City] = try subject.parse(data: invalidJson)
        } catch {
            parseError = error
        }
        
        XCTAssertNotNil(parseError)
    }
}

private extension CitiesWeatherJsonDecoderImplTests {
    var expectedCities: [City] {
        [.city1, .city2]
    }
    
    var expectedResponse: CitiesResponse {
        CitiesResponse(cities: expectedCities)
    }
    
    var validJson: Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        return try! encoder.encode(expectedResponse)
    }
    
    var invalidJson: Data {
        Data()
    }
}
