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
    var deeplinkData: String = ""

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.goToController(goTo: SBConstants.launchScreen, withIdentifier: "LaunchScreenVCID")
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("url => ",url)
        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        
        if queryItems?.contains(where: { $0.name == "error" }) == true  {
            
            let alert = UIAlertController(title: queryItems?.first(where: { $0.name == "error" })?.value,
                              message: queryItems?.first(where: { $0.name == "error_description" })?.value,
                              preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            window?.rootViewController?.present(alert, animated: true, completion: nil)
            
        }else if let code = queryItems?.first(where: { $0.name == "code"}) {
            self.deeplinkData = code.value ?? ""
            let vc = SBConstants.home.instantiateViewController(withIdentifier: "AccountAuthoricationVCID") as! AccountAuthoricationVC
            vc.setData(code: code.value)
            vc.modalPresentationStyle = .fullScreen
            self.window?.rootViewController = vc
        }
        
        return true
        
    }
    
    func goToController(goTo storyboard: UIStoryboard, withIdentifier identifier: String) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        self.window?.rootViewController = controller
    }
    
}

