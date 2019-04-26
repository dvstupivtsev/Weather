//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import Foundation

// TODO: Обернуть в объект
protocol UrlService {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: UrlService { }
