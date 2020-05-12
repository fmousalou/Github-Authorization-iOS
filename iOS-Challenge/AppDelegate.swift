//
//  AppDelegate.swift
//  iOS-Challenge
//
//  Created by Farshad Mousalou on 1/28/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import KeychainSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let prefrence = FirstRunPrefrences()
        prefrence.keychainSetup()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("url => ",url)
        let keychain = KeychainSwift()
        let util = Utilities()
        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        if queryItems?.contains(where: { $0.name == "error" }) == true  {
            let message = queryItems?.first(where: { $0.name == "error_description" })?.value ?? "something went wrong. you're not logged in."
            let title   = queryItems?.first(where: { $0.name == "error" })?.value ?? "error"
            util.showAlert(message: message, title: title , buttonTitle: "OK")
        }else if let code = queryItems?.first(where: { $0.name == "code"}) {
            keychain.set(code.value ?? "", forKey: "token")
            Global.token = code.value
            Router.goTo.mainTabbar()
        }
        return true
        
    }
    
}

