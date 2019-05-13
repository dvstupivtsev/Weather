//
//  Created by Dmitriy Stupivtsev on 12/05/2019.
//

import XCTest
@testable import Weather

final class CityWeatherFormatterImplTests: XCTestCase {
    private var subject: CityWeatherFormatterImpl!
    private var numberFormatter: NumberFormatterProtocolMock!
    private var currentDateFormatter: DateFormatterProtocolMock!
    private var forecastDateFormatter: DateFormatterProtocolMock!
    private var forecastWeekdayDateFormatter: DateFormatterProtocolMock!
    private var hourlyForecastDateFormatter: DateFormatterProtocolMock!
    private var temperatureFormatter: MeasurementFormatterProtocolMock!
    
    override func setUp() {
        super.setUp()
        
        numberFormatter = .init()
        numberFormatter.stringFromReturnValue = "TestFormatterNumber"
        
        currentDateFormatter = .init()
        currentDateFormatter.stringFromReturnValue = "TestFormatterCurrentDate"
        
        forecastDateFormatter = .init()
        forecastDateFormatter.stringFromReturnValue = "TestFormattedForecastDate"
        
        forecastWeekdayDateFormatter = .init()
        forecastWeekdayDateFormatter.stringFromReturnValue = "TestFormattedForecastWeekday"
        
        hourlyForecastDateFormatter = .init()
        hourlyForecastDateFormatter.stringFromReturnValue = "TestFormattedHourlyForecastDate"
        
        temperatureFormatter = .init()
        temperatureFormatter.stringFromReturnValue = "TestFormattedTemperature"
        
        subject = CityWeatherFormatterImpl(
            numberFormatter: numberFormatter,
            currentDateFormatter: currentDateFormatter,
            forecastDateFormatter: forecastDateFormatter,
            forecastWeekdayDateFormatter: forecastWeekdayDateFormatter,
            hourlyForecastDateFormatter: hourlyForecastDateFormatter,
            temperatureFormatter: temperatureFormatter
        )
    }

    func testFormatTemperatureValue() {
        let value: Double = 1234.1234
        let receivedValue = subject.formatTemperatureValue(value)
        
        XCTAssertEqual(receivedValue, numberFormatter.stringFromReturnValue)
        XCTAssertEqual(numberFormatter.stringFromCallsCount, 1)
        XCTAssertEqual(numberFormatter.stringFromReceivedValue, value)
    }
    
    func testFormatCurrentDate() {
        let value = Constants.date
        let receivedValue = subject.formatCurrentDate(value)
        
        XCTAssertEqual(receivedValue, currentDateFormatter.stringFromReturnValue)
        XCTAssertEqual(currentDateFormatter.stringFromCallsCount, 1)
        XCTAssertEqual(currentDateFormatter.stringFromReceivedFrom, value)
    }
    
    func testFormatForecastDate() {
        let value = Constants.date
        let receivedValue = subject.formatForecastDate(value)
        
        XCTAssertEqual(receivedValue, forecastDateFormatter.stringFromReturnValue)
        XCTAssertEqual(forecastDateFormatter.stringFromCallsCount, 1)
        XCTAssertEqual(forecastDateFormatter.stringFromReceivedFrom, value)
    }
    
    func testFormatForecastWeekday() {
        let value = Constants.date
        let receivedValue = subject.formatForecastWeekday(value)
        
        XCTAssertEqual(receivedValue, forecastWeekdayDateFormatter.stringFromReturnValue)
        XCTAssertEqual(forecastWeekdayDateFormatter.stringFromCallsCount, 1)
        XCTAssertEqual(forecastWeekdayDateFormatter.stringFromReceivedFrom, value)
    }
    
    func testFormatHourlyForecastDate() {
        let value = Constants.date
        let receivedValue = subject.formatHourlyForecastDate(value)
        
        XCTAssertEqual(receivedValue, hourlyForecastDateFormatter.stringFromReturnValue)
        XCTAssertEqual(hourlyForecastDateFormatter.stringFromCallsCount, 1)
        XCTAssertEqual(hourlyForecastDateFormatter.stringFromReceivedFrom, value)
    }
    
    func testFormatForecastTemperature() {
        let value: Double = 1234.1234
        let receivedValue = subject.formatForecastTemperature(value)
        
        XCTAssertEqual(receivedValue, temperatureFormatter.stringFromReturnValue)
        XCTAssertEqual(temperatureFormatter.stringFromCallsCount, 1)
        XCTAssertEqual(temperatureFormatter.stringFromReceivedDoubleCelsius, value)
    }
}
