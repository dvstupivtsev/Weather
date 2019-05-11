//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

final class CitiesWeatherJsonDecoderImpl: JsonDecoder<CitiesResponse>, CitiesWeatherJsonDecoder {
    func parse(data: Data?) throws -> [City] {
        return try parse(data: data).cities
    }
}
