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
    let appDIContainer = AppDIContainer()
    
    /// Setup appearance and make the first view controller
    /// - Parameter application: current application
    /// - Parameter launchOptions: launch options passed to app
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        AppAppearance.setupAppearance()        
        
        appDIContainer.keyChainBearerTokenRepository.fetch { (result) in
            switch result {
            case .success(let token):
                DispatchQueue.main.async {
                    self.presentMainScene(token: token)
                }
            case.failure(_):
                DispatchQueue.main.async {
                    self.presentAuthorizationScene()
                }
            }
        }
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
            
        }else if let code = queryItems?.first(where: { $0.name == "code"}), let token = code.value {
            NotificationCenter.postNotification(name: .recievedTokenFromServer, userInfo: [NotificationObjectKeys.oAuthToken:token])
        }
        return true
    }

    private func presentAuthorizationScene(){
        window = UIWindow(frame: UIScreen.main.bounds)
        let authorizationViewController = appDIContainer.makeAuthorizationSceneDIContainer().makeAuthorizationViewController()
        let navigationController = UINavigationController(rootViewController: authorizationViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func presentMainScene(token: String){
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainViewController = appDIContainer.makeMainSceneDIContainer().makeMainView()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

