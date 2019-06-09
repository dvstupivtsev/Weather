//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import Foundation
@testable import Weather

extension City {
    static let city1 = City(
        id: 1,
        name: "Name1",
        date: Constants.date,
        coordinate: .init(lat: 1, lon: 2),
        weather: [.init(description: "Desc1", icon: "Icon1")],
        main: .init(temp: 1)
    )
    
    static let city2 = City(
        id: 2,
        name: "Name2",
        date: Constants.date,
        coordinate: .init(lat: 2, lon: 3),
        weather: [.init(description: "Desc2", icon: "Icon2")],
        main: .init(temp: 2)
    )
    
    static let city3 = City(
        id: 3,
        name: "Name3",
        date: Constants.date,
        coordinate: .init(lat: 4, lon: 5),
        weather: [.init(description: "Desc3", icon: "Icon3")],
        main: .init(temp: 3)
    )
}
