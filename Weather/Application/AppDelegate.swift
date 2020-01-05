//
//  Created by Dmitriy Stupivtsev on 26/04/2019.
//

import UIKit
import Prelude

// TODO: move calls to app manager or smth else for testing
final class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow()
    
    private lazy var persistentStore = PersistentStoreFactory().createCoreDataStore()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let router = persistentStore
            |> WeatherPageContainerFactory.init(persistentStore:)
            >>> WindowRouter.init(controllerFactory:)
        router.setRoot(window:) <*> window
        
        SVProgressHUD.setDefaultStyle(.dark)
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        persistentStore.save()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        persistentStore.save()
    }
}
