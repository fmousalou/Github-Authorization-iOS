//
//  AppDelegate.swift
//  iOS-Challenge
//
//  Created by Farshad Mousalou on 1/28/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navController)
        coordinator?.start()

        // create a basic UIWindow and activate it
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems

        if queryItems?.contains(where: { $0.name == "error" }) == true  {
            //Show Error in Toast
        }else if let code = queryItems?.first(where: { $0.name == "code"}) {
            coordinator?.resumeAuthentication(with: code.value)
//            (window?.rootViewController as? LoginController)?.getAuthentication(with: code.value)
        }
        return true
    }
}

