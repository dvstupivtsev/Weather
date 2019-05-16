//
//  Created by Dmitriy Stupivtsev on 16/05/2019.
//

import Foundation

struct DiskJsonFileReader: DiskFileReader {
    func data(for fileName: String) throws -> Data {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            throw NSError.common
        }
        
        let url = URL(fileURLWithPath: path)
        return try Data(contentsOf: url, options: .mappedIfSafe)
    }
}
