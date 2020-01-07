//
//  Created by Dmitriy Stupivtsev on 15/05/2019.
//

import Foundation
@testable import Weather

struct TableCellProviderConvertibleMock: TableCellProviderConvertible, Equatable {
    private let id: Int
    
    var cellProvider: TableCellProvider {
        TableCellProviderMock()
    }
    
    init(id: Int) {
        self.id = id
    }
    
    static func ==(lhs: TableCellProviderConvertibleMock, rhs: TableCellProviderConvertibleMock) -> Bool {
        lhs.id == rhs.id
    }
}
