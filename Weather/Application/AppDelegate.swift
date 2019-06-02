//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit

// TODO: move calls to app manager or smth else for testing
final class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow()
    
    private lazy var persistentStore = PersistentStoreFactory().createCoreDataStore()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let pageContainerFactory = WeatherPageContainerFactory(persistentStore: persistentStore)
        let router = WindowRouter(controllerFactory: pageContainerFactory)
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
