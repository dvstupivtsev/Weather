//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow()
    
    private lazy var persistentStore = PersistentStoreFactory().createCoreDataStore()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let router = WindowRouter(controllerFactory: WeatherPageContainerFactory())
        window.map(router.setRoot(window:))
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        persistentStore.save()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        persistentStore.save()
    }
}
