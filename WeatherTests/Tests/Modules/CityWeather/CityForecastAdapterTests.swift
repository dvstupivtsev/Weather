//
//  Created by Dmitriy Stupivtsev on 13/05/2019.
//

import XCTest
@testable import Weather
@testable import Promises

final class CityForecastAdapterTests: XCTestCase {
    private let cityId = 123
    
    private var subject: CityForecastAdapter!
    private var forecastService: ForecastServiceMock!
    
    override func setUp() {
        super.setUp()
        
        forecastService = ForecastServiceMock()
        subject = CityForecastAdapter(forecastService: forecastService)
    }
    
    func testGetForecastWithEmptyResult() {
        forecastService.getForecastForReturnValue = Promise([])
        let result = subject.getForecast(for: cityId)
        
        XCTAssertEqual(forecastService.getForecastForCallsCount, 1)
        XCTAssertEqual(forecastService.getForecastForReceivedCityId, cityId)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEmpty(result.value?.hourlyForecast)
        XCTAssertEmpty(result.value?.dailyForecast)
        XCTAssertNil(result.error)
    }
    
    func testGetForecastWithSameDays() {
        forecastService.getForecastForReturnValue = Promise(forecastWithSomeSameDays)
        let result = subject.getForecast(for: cityId)
        
        XCTAssertEqual(forecastService.getForecastForCallsCount, 1)
        XCTAssertEqual(forecastService.getForecastForReceivedCityId, cityId)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(result.value?.hourlyForecast, expectedHourlyForecastFromSomeSameDays)
        XCTAssertEqual(result.value?.dailyForecast, expectedDailyForecastFromSomeSameDays)
        XCTAssertNil(result.error)
    }
    
    func testGetForecastWithDifferentDays() {
        forecastService.getForecastForReturnValue = Promise(forecastWithDifferentDays)
        let result = subject.getForecast(for: cityId)
        
        XCTAssertEqual(forecastService.getForecastForCallsCount, 1)
        XCTAssertEqual(forecastService.getForecastForReceivedCityId, cityId)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(result.value?.hourlyForecast, expectedHourlyForecastFromDifferentDays)
        XCTAssertEqual(result.value?.dailyForecast, expectedDailyForecastFromDifferentDays)
        XCTAssertNil(result.error)
    }
    
    func testGetForecastFailure() {
        let expectedError = Constants.error
        forecastService.getForecastForReturnValue = Promise(expectedError)
        let result = subject.getForecast(for: cityId)
        
        XCTAssertEqual(forecastService.getForecastForCallsCount, 1)
        XCTAssertEqual(forecastService.getForecastForReceivedCityId, cityId)
        
        XCTAssert(waitForPromises(timeout: 1))
        XCTAssertEqual(result.error as NSError?, expectedError)
        XCTAssertNil(result.value)
    }
}

private extension CityForecastAdapterTests {
    var forecastWithSomeSameDays: [Forecast] {
        return [
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/13/2019 08:22 AM")!,
                temperature: Forecast.Temperature(value: 1, min: 2, max: 3),
                weather: [Weather(description: "Desc1", icon: "Icon1")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/13/2019 02:22 PM")!,
                temperature: Forecast.Temperature(value: 4, min: 5, max: 6),
                weather: [Weather(description: "Desc2", icon: "Icon2")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/14/2019 08:22 AM")!,
                temperature: Forecast.Temperature(value: 7, min: 8, max: 9),
                weather: [Weather(description: "Desc3", icon: "Icon3")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/14/2019 02:22 PM")!,
                temperature: Forecast.Temperature(value: 10, min: 11, max: 12),
                weather: [Weather(description: "Desc4", icon: "Icon4")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/15/2019 08:22 AM")!,
                temperature: Forecast.Temperature(value: 13, min: 14, max: 15),
                weather: [Weather(description: "Desc5", icon: "Icon5")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/15/2019 04:22 AM")!,
                temperature: Forecast.Temperature(value: 16, min: 17, max: 18),
                weather: [Weather(description: "Desc6", icon: "Icon6")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/15/2019 09:22 AM")!,
                temperature: Forecast.Temperature(value: 19, min: 20, max: 21),
                weather: [Weather(description: "Desc7", icon: "Icon7")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/15/2019 06:22 PM")!,
                temperature: Forecast.Temperature(value: 22, min: 23, max: 24),
                weather: [Weather(description: "Desc8", icon: "Icon8")]
            )
        ]
    }
    
    var expectedHourlyForecastFromSomeSameDays: [Forecast] {
        return forecastWithSomeSameDays
    }
    
    var expectedDailyForecastFromSomeSameDays: [Forecast] {
        return [
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/13/2019 08:22 AM")!.startOfDay,
                temperature: Forecast.Temperature(value: 2.5, min: 2, max: 6),
                weather: [Weather(description: "Desc1", icon: "Icon1")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/14/2019 08:22 AM")!.startOfDay,
                temperature: Forecast.Temperature(value: 8.5, min: 8, max: 12),
                weather: [Weather(description: "Desc3", icon: "Icon3")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/15/2019 08:22 AM")!.startOfDay,
                temperature: Forecast.Temperature(value: 17.5, min: 14, max: 24),
                weather: [Weather(description: "Desc5", icon: "Icon5")]
            ),
        ]
    }
    
    var forecastWithDifferentDays: [Forecast] {
        return [
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/13/2019 08:22 AM")!,
                temperature: Forecast.Temperature(value: 1, min: 2, max: 3),
                weather: [Weather(description: "Desc1", icon: "Icon1")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/14/2019 11:22 AM")!,
                temperature: Forecast.Temperature(value: 4, min: 5, max: 6),
                weather: [Weather(description: "Desc2", icon: "Icon2")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/15/2019 08:22 AM")!,
                temperature: Forecast.Temperature(value: 7, min: 8, max: 9),
                weather: [Weather(description: "Desc3", icon: "Icon3")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/16/2019 06:22 PM")!,
                temperature: Forecast.Temperature(value: 10, min: 11, max: 12),
                weather: [Weather(description: "Desc4", icon: "Icon4")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/17/2019 08:22 AM")!,
                temperature: Forecast.Temperature(value: 13, min: 14, max: 15),
                weather: [Weather(description: "Desc5", icon: "Icon5")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/18/2019 04:22 AM")!,
                temperature: Forecast.Temperature(value: 16, min: 17, max: 18),
                weather: [Weather(description: "Desc6", icon: "Icon6")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/19/2019 09:22 AM")!,
                temperature: Forecast.Temperature(value: 19, min: 20, max: 21),
                weather: [Weather(description: "Desc7", icon: "Icon7")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/20/2019 06:22 PM")!,
                temperature: Forecast.Temperature(value: 22, min: 23, max: 24),
                weather: [Weather(description: "Desc8", icon: "Icon8")]
            ),
            Forecast(
                date: DateFormatter.MM_dd_yyyy_hh_mm_a.date(from: "05/21/2019 08:22 AM")!,
                temperature: Forecast.Temperature(value: 25, min: 26, max: 27),
                weather: [Weather(description: "Desc9", icon: "Icon9")]
            )
        ]
    }
    
    var expectedHourlyForecastFromDifferentDays: [Forecast] {
        return Array(forecastWithDifferentDays[0..<8])
    }
    
    var expectedDailyForecastFromDifferentDays: [Forecast] {
        return forecastWithDifferentDays.map {
            return Forecast(
                date: $0.date.startOfDay,
                temperature: $0.temperature,
                weather: $0.weather
            )
        }
    }
}
