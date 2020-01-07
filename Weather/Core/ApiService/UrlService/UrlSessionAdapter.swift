//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation
import Promises

final class UrlSessionAdapter: UrlService {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func dataTask(with url: URL) -> Promise<Data?> {
        Promise(on: .global(qos: .userInteractive)) { fulfill, reject in
            self.session.dataTask(with: url) { data, response, error in
                if let error = error {
                    reject(error)
                } else {
                    fulfill(data)
                }
            }.resume()
        }
    }
}
