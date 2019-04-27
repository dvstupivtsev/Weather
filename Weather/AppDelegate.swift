//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = CitiesFactory().create()
        window?.makeKeyAndVisible()
        
        return true
    }
}

