//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window?.rootViewController = CitiesFactory().createWithNavigation()
        window?.makeKeyAndVisible()
        
        return true
    }
}

