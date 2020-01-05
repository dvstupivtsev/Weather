//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

final class ForecastJsonDecoderImpl: JsonDecoder<Forecasts>, ForecastJsonDecoder {
    func parse(data: Data?) throws -> [Forecast] {
        try parse(data: data).list
    }
}
