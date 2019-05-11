//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

final class DailyForecastJsonDecoderImpl: JsonDecoder<DailyForecast>, DailyForecastJsonDecoder {
    func parse(data: Data?) throws -> [DayWeather] {
        return try parse(data: data).list
    }
}
