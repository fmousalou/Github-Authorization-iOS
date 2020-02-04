//
//  AppDelegate.swift
//  iOS-Challenge
//
//  Created by Farshad Mousalou on 1/28/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        IQKeyboardManager.shared.enable = true
        configureApi()
        configureFirstVC()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        HandleRcivedURL(url)
        
        return true
        
    }
    
}


// MARK: - Handle Deep Link

extension AppDelegate {
    
    fileprivate func HandleRcivedURL(_ url: URL) {
        print("----------callBackURL => ",url)
        if let urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            let path = urlComponent.path
            // seprate diffrent callbacks
            if path.contains(CallBackKeys.gitAuthorizationcallback.rawValue){
                HandleAuthorizationCallBack(urlComponent)
            }
        }
    }
    
    // save data after git authorization
    fileprivate func HandleAuthorizationCallBack(_ urlComponent: URLComponents) {
        let queryItems = urlComponent.getQueryItems()
        if queryItems.count > 0 {
            if let error = queryItems["error"]{
                var errorDescription = queryItems["error_description"] ?? "Authorization Failed Please try again"
                errorDescription = errorDescription.replacingOccurrences(of: "+", with: " ")
                UIApplication.topViewController()?.showAlert(title: error, message: errorDescription)
            }else if let code = queryItems["code"] {
                let userDataHelper = UserDataHelper()
                userDataHelper.setToken(token: code)
                NotificationCenter.default.post(name: .authorized, object: nil)
            }
        }
    }
}

// MARK: - Configuration app

extension AppDelegate{
    
    fileprivate func configureApi() {
        HTTPManager.configure(with: [:],baseUrl: URL(string: "https://github.com/")!)
        HTTPManager.shared.append(headers: ["client_id": clientId,
                                            "redirect_uri": "challenge://app/callback",
                                            "scope": "repo",
                                            "state": "0"])
    }
    
    /// Configure First ViewController
    fileprivate func configureFirstVC() {
        let userDataHelper = UserDataHelper()
        if let token = userDataHelper.getToken(){
            // add token API Headers
            HTTPManager.shared.append(headers: ["token": token])
            // if authorized show RepositoryViewController
            let storyboard               = UIStoryboard(name: "Main", bundle: nil)
            let rootNavigationController = storyboard.instantiateViewController(withIdentifier: "rootNavigation")
            UIApplication.shared.setRoot(viewController: rootNavigationController)
        }
    }
}
