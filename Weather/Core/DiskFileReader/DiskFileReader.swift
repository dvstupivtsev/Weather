//
//  Created by Dmitriy Stupivtsev on 16/05/2019.
//

import Foundation

// sourcery: AutoMockable
protocol DiskFileReader {
    func data(for fileName: String) throws -> Data
}
