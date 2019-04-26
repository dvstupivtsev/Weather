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
        
        urlService.dataTask(with: url) {
            do {
                completion(.success(try $0.get()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func createURL(request: ApiServiceRequest) -> URL? {
        let joinedParams = request.parameters
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
        
        let urlString = "\(baseURLString)\(request.name)?\(joinedParams)&APPID=\(apiKey)"
        
        return URL(string: urlString)
    }
}
