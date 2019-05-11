//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import XCTest
@testable import Weather

final class DailyForecastJsonDecoderImplTests: XCTestCase {
    private var subject: DailyForecastJsonDecoderImpl!
    override func setUp() {
        super.setUp()
        
        subject = DailyForecastJsonDecoderImpl()
    }
    
    func testParseDataWithValidJson() {
        let receivedForecast: DailyForecast = try! subject.parse(data: validJson)
        let receivedWeathers: [DayWeather] = try! subject.parse(data: validJson)
        
        XCTAssertEqual(receivedForecast, expectedForecast)
        XCTAssertEqual(receivedWeathers, expectedWeathers)
    }
    
    func testParseDataWithInvalidJson() {
        var parseError: Error?
        do {
            let _: DailyForecast = try subject.parse(data: invalidJson)
        } catch {
            parseError = error
        }
        
        XCTAssertNotNil(parseError)
        
        do {
            let _: [DayWeather] = try subject.parse(data: invalidJson)
        } catch {
            parseError = error
        }
        
        XCTAssertNotNil(parseError)
    }
}

private extension DailyForecastJsonDecoderImplTests {
    var expectedWeathers: [DayWeather] {
        return [.weather1, .weather2]
    }
    
    var expectedForecast: DailyForecast {
        return DailyForecast(list: expectedWeathers)
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
