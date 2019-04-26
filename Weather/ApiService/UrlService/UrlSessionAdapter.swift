//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

final class UrlSessionAdapter: UrlService {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func dataTask(with url: URL, completion: @escaping ResultHandler<Data?>) {
        session.dataTask(with: url) { [weak self] in
            self?.handleDataTask(result: ($0, $1, $2), completion: completion)
        }.resume()
    }
    
    private func handleDataTask(
        result: (data: Data?, response: URLResponse?, error: Error?),
        completion: @escaping ResultHandler<Data?>
    ) {
        if let error = result.error {
            completion(.failure(error))
        } else {
            completion(.success(result.data))
        }
    }
}
