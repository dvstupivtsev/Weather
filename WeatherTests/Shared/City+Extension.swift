//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import Foundation
@testable import Weather

extension City {
    static let city1 = City(
        id: 1,
        name: "Name1",
        date: Date(),
        coordinate: .init(lat: 1, lon: 2),
        weather: [.init(icon: "Icon1")],
        main: .init(temp: 1)
    )
    
    static let city2 = City(
        id: 2,
        name: "Name2",
        date: Date(),
        coordinate: .init(lat: 2, lon: 3),
        weather: [.init(icon: "Icon2")],
        main: .init(temp: 2)
    )
}
