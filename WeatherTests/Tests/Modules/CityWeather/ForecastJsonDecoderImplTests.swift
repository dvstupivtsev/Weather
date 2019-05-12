//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import XCTest
@testable import Weather
    
final class ForecastJsonDecoderImplTests: XCTestCase {
    private var subject: ForecastJsonDecoderImpl!
    
    override func setUp() {
        super.setUp()
        
        subject = ForecastJsonDecoderImpl()
    }
    
    func testParseDataWithValidJson() {
        let receivedForecasts: Forecasts = try! subject.parse(data: validJson)
        let receivedForecastList: [Forecast] = try! subject.parse(data: validJson)
        
        XCTAssertEqual(receivedForecasts, expectedForecasts)
        XCTAssertEqual(receivedForecastList, expectedForecastList)
    }
    
    func testParseDataWithInvalidJson() {
        var parseError: Error?
        do {
            let _: Forecasts = try subject.parse(data: invalidJson)
        } catch {
            parseError = error
        }
        
        XCTAssertNotNil(parseError)
        
        do {
            let _: [Forecast] = try subject.parse(data: invalidJson)
        } catch {
            parseError = error
        }
        
        XCTAssertNotNil(parseError)
    }
}

private extension ForecastJsonDecoderImplTests {
    var expectedForecastList: [Forecast] {
        return [.forecast1, .forecast2]
    }
    
    var expectedForecasts: Forecasts {
        return Forecasts(list: expectedForecastList)
    }
    
    var validJson: Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        return try! encoder.encode(expectedForecasts)
    }
    
    var invalidJson: Data {
        return Data()
    }
}
