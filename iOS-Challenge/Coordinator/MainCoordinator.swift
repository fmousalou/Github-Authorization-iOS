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
        navigationController.navigationBar.barTintColor = .blue
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        let kc = KeychainAPI()
        if let token = kc.token {
            login()
        }else {
            main()
        }
    }
    
    func login() {
        let vc = LoginController.instantiate()
        navigationController.pushViewController(vc, animated: false)
    }
    
    func main() {
        print("I'm going to open main page!!!")
    }
}


