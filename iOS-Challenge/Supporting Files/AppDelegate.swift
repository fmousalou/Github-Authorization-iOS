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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        handleDeepLinkOnGithubAuthorization(url)
    }
    
}
extension AppDelegate {
    fileprivate func handleDeepLinkOnGithubAuthorization(_ url: URL) -> Bool {
        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        
        if queryItems?.contains(where: { $0.name == "error" }) == true  {
            let title = queryItems?.first(where: { $0.name == "error" })?.value
            let message = queryItems?.first(where: { $0.name == "error_description" })?.value
            window?.rootViewController?.showAlert(withTitle: title, withMessage: message, nil, nil)
        } else if let code = queryItems?.first(where: { $0.name == "code"})?.value {
            (window?.rootViewController as? AuthorizationViewController)?.getAuthenticationCode(with: code)
        }
        return true
    }
}

