//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation
import Promises
import Prelude

final class ApiServiceImpl: ApiService {
    private let urlService: UrlService
    
    private let apiKey = "95ff45a9380c75f19a9a9ef20502dac9"
    private let baseURLString = "https://api.openweathermap.org/data/2.5/"
    
    init(urlService: UrlService) {
        self.urlService = urlService
    }
    
    func execute(request: ApiServiceRequest) -> Promise<Data?> {
        createURL(request: request)
            .apply(urlService.dataTask)
            ?? Promise(NSError.common)
    }
    
    
    private func createURL(request: ApiServiceRequest) -> URL? {
        request.parameters
            |> map { "\($0.key)=\($0.value)" }
            >>> joined(separator: "&")
            >>> { "\(self.baseURLString)\(request.name)?\($0)&appid=\(self.apiKey)" }
            >>> URL.init
    }
}
