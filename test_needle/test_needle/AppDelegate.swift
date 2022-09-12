//
//  AppDelegate.swift
//  test_needle
//
//  Created by 김남수 on 2022/09/09.
//

import UIKit
import NeedleFoundation
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        registerProviderFactories()
        
        let root = RootComponent()
        let rootVC = root.rootViewController
        rootVC.view.backgroundColor = .systemBackground
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }
}

