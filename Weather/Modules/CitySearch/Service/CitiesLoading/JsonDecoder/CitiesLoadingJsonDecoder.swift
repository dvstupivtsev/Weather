//
//  Created by Dmitriy Stupivtsev on 16/05/2019.
//

import Foundation

// sourcery: AutoMockable
protocol CitiesLoadingJsonDecoder {
    func parse(data: Data?) throws -> [CityModel]
}
