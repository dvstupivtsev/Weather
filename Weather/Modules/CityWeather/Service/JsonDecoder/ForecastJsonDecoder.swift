//
//  Created by Dmitriy Stupivtsev on 11/05/2019.
//

import Foundation

// sourcery: AutoMockable
protocol ForecastJsonDecoder {
    func parse(data: Data?) throws -> [Forecast]
}
