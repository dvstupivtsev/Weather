//
//  Created by Dmitriy Stupivtsev on 10/05/2019.
//

import UIKit
@testable import Weather

struct Constants {
    static let controller = UIViewController()
    static let error = NSError.error(message: "Test")
    static let date = Date(timeIntervalSince1970: 1557569160)
    static let data = "Test".data(using: .utf8)!
}
