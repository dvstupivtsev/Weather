//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation
import Promises

final class ApiServiceImpl: ApiService {
    private let urlService: UrlService
    
    private let apiKey = "95ff45a9380c75f19a9a9ef20502dac9"
    private let baseURLString = "https://api.openweathermap.org/data/2.5/"
    
    init(urlService: UrlService) {
        self.urlService = urlService
    }
    
    func execute(request: ApiServiceRequest) -> Promise<Data?> {
        guard let url = createURL(request: request) else {
            return Promise(NSError.common)
        }
        
        return urlService.dataTask(with: url)
    }
    
    
    private func createURL(request: ApiServiceRequest) -> URL? {
        let joinedParams = request.parameters
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
        
        let urlString = "\(baseURLString)\(request.name)?\(joinedParams)&appid=\(apiKey)"
        
        return URL(string: urlString)
    }
}
