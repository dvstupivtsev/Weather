//
//  Created by Dmitriy Stupivtsev on 28/04/2019.
//

import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil

let appDelegateClass = isRunningTests
    ? NSStringFromClass(TestingAppDelegate.self)
    : NSStringFromClass(AppDelegate.self)

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    appDelegateClass
)
