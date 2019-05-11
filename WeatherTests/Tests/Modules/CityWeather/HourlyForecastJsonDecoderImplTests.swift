//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import XCTest
@testable import Weather
    
final class HourlyForecastJsonDecoderImplTests: XCTestCase {
    private var subject: HourlyForecastJsonDecoderImpl!
    
    override func setUp() {
        super.setUp()
        
        subject = HourlyForecastJsonDecoderImpl()
    }
    
    func testParseDataWithValidJson() {
        let receivedForecast: HourlyForecast = try! subject.parse(data: validJson)
        let receivedWeathers: [HourWeather] = try! subject.parse(data: validJson)
        
        XCTAssertEqual(receivedForecast, expectedForecast)
        XCTAssertEqual(receivedWeathers, expectedWeathers)
    }
    
    func testParseDataWithInvalidJson() {
        var parseError: Error?
        do {
            let _: HourlyForecast = try subject.parse(data: invalidJson)
        } catch {
            parseError = error
        }
        
        XCTAssertNotNil(parseError)
        
        do {
            let _: [HourWeather] = try subject.parse(data: invalidJson)
        } catch {
            parseError = error
        }
        
        XCTAssertNotNil(parseError)
    }
}

private extension HourlyForecastJsonDecoderImplTests {
    var expectedWeathers: [HourWeather] {
        return [.weather1, .weather2]
    }
    
    var expectedForecast: HourlyForecast {
        return HourlyForecast(list: expectedWeathers)
    }
    
    var validJson: Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        return try! encoder.encode(expectedForecast)
    }
    
    var invalidJson: Data {
        return Data()
    }
}
