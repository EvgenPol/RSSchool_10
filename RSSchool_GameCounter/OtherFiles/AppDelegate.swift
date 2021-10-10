//
//  AppDelegate.swift
//  RSSchool_GameCounter
//
//  Created by Евгений Полюбин on 25.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        let rootViewController: NavigationViewController
        
        if GameCounter.shared.isGameRun {
            rootViewController = NavigationViewController(rootViewController: GameProcessViewController())
        } else {
            rootViewController = NavigationViewController(rootViewController: NewGameViewController())
        }
    
        window.rootViewController = rootViewController
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        UserDefaults.standard.synchronize()
    }
}

