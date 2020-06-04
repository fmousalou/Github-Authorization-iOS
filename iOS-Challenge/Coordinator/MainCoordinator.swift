//
//  MainCoordinator.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//


import UIKit
import Moya

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.barTintColor = .blue
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        
        main()
        return
        
        let kc = KeychainAPI()
        if let token = kc.token {
            print("Token: \(token)")
            main()
        }else {
            login()
        }
    }
    
    func main() {
        print("I'm going to open main page!!!")
        let searchVC = SearchController()
        navigationController.pushViewController(searchVC, animated: false)
    }
    
    func userInfo() {
        let userVC = UserController(keychain: KeychainAPI())
        navigationController.pushViewController(userVC, animated: false)
    }
}

// MARK:- Login
extension MainCoordinator {
    func login() {
        let loginVC = LoginController.instantiate()
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: false)
    }
    
    func openGithub() {
        let urlStr = "https://github.com/login/oauth/authorize"
        if let githubAuthURL = urlStr.githubURL {
            UIApplication.shared.open(githubAuthURL,
                                      options: [:])
        }
    }
    
    // Come from deep link
    func resumeAuthentication(with parameters: QueryParameters) {
        guard let loginVC = navigationController.topViewController as? LoginController else {
            return
        }
        loginVC.getAuthentication(with: parameters)
    }
}


