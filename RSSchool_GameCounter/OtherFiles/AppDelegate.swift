//
//  AppDelegate.swift
//  RSSchool_GameCounter
//
//  Created by Евгений Полюбин on 25.08.2021.
//

import UIKit

let widthScreen = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
let heightScreen = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        let rootViewController = NavigationViewController.init(rootViewController: NewGameViewController())
        
        window.rootViewController = rootViewController
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}

