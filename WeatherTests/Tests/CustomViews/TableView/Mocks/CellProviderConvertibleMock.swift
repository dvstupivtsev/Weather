//
//  Created by Dmitriy Stupivtsev on 15/05/2019.
//

import Foundation
@testable import Weather

struct CellProviderConvertibleMock: CellProviderConvertible, Equatable {
    private let id: Int
    
    var cellProvider: CellProvider {
        return CellProviderMock()
    }
    
    init(id: Int) {
        self.id = id
    }
    
    static func ==(lhs: CellProviderConvertibleMock, rhs: CellProviderConvertibleMock) -> Bool {
        return lhs.id == rhs.id
    }
}
