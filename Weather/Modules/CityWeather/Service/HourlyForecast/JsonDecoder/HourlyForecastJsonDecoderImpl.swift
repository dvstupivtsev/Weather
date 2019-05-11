//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

final class HourlyForecastJsonDecoderImpl: JsonDecoder<HourlyForecast>, HourlyForecastJsonDecoder {
    func parse(data: Data?) throws -> [HourWeather] {
        return try parse(data: data).list
    }
}
