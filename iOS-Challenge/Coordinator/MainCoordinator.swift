//
//  MainCoordinator.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.barTintColor = .systemBlue
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        let token = KeychainAPI.shared.token
        if token != nil { // Logged on once
            search()
        }else { // It's first time
            login()
        }
    }
    
    func search() {
        if navigationController.loggedInRecently {
            // Logged in successfully
            // So Remove LoginController from stack
            navigationController.viewControllers.removeLast()
        }
        
        let searchVC = SearchController()
        searchVC.coordinator = self
        navigationController.pushViewController(searchVC, animated: true)
    }
    
    func userInfo() {
        let userVC = UserController()
        navigationController.pushViewController(userVC, animated: true)
    }
    
    func commits(url: String) {
        let commitsVC = CommitsController(url: url.commitsURLPath!)
        navigationController.pushViewController(commitsVC, animated: true)
    }
}

// MARK:- Login
extension MainCoordinator {
    func login() {
        let loginVC = LoginController.instantiate()
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: false)
    }
    
    // Start authorize
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


