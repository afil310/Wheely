//
//  AppDelegate.swift
//  Wheely
//
//  Created by Andrey Filonov on 18/03/2019.
//  Copyright © 2019 Andrey Filonov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let inputViewController = InputViewController()
        let navigationController = UINavigationController(rootViewController: inputViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

