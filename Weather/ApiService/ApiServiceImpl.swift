//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

final class ApiServiceImpl: ApiService {
    private let urlService: UrlService
    
    private let apiKey = "95ff45a9380c75f19a9a9ef20502dac9"
    private let baseURLString = "https://api.openweathermap.org/data/2.5/"
    
    init(urlService: UrlService) {
        self.urlService = urlService
    }
    
    func execute(request: ApiServiceRequest, completion: @escaping ResultHandler<Data?>) {
        guard let url = createURL(request: request) else {
            completion(.failure(NSError.common))
            return
        }
        
        urlService.dataTask(with: url) { [weak self] in
            self?.handleDataTask(result: ($0, $1, $2), completion: completion)
        }.resume()
    }
    
    private func createURL(request: ApiServiceRequest) -> URL? {
        let joinedParams = request.parameters
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
        
        let urlString = "\(baseURLString)\(request.name)?\(joinedParams)&APPID=\(apiKey)"
        
        return URL(string: urlString)
    }
    
    private func handleDataTask(
        result: (data: Data?, response: URLResponse?, error: Error?),
        completion: ResultHandler<Data?>
    ) {
        if let error = result.error {
            completion(.failure(error))
        } else {
            completion(.success(result.data))
        }
    }
}
