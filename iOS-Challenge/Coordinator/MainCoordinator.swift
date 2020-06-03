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
    }
}

// MARK:- Login
extension MainCoordinator {
    func login() {
        let loginVC = LoginController.instantiate()
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: false)
    }
    
    // Come from deep link
    func resumeAuthentication(with code: String?) {
        guard let loginVC = navigationController.topViewController as? LoginController else {
            return
        }
        loginVC.getAuthentication(with: code)
    }
}


