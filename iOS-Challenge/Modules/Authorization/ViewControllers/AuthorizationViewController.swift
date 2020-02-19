//
//  ViewController.swift
//  iOS-Challenge
//
//  Created by Farshad Mousalou on 1/28/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import Alamofire
import SafariServices

class AuthorizationViewController: UIViewController {
    
    //MARK: - Actions -
    @IBAction func loginDidPress(_ sender: Any?) {
        viewModel.login { (result) in
            switch result {
            case .success(let url):
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            case .failure(let error):
                handleError(error: error)
            }
        }
    }
    //MARK: - Vars -
    var viewModel = AuthorizationViewModel()
    
    //MARK: - View's LifeCycle -

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = UserDefaultsService.shared.getToken() {
            navigateToRepositories()
        }
    }

    //MARK: - Functions -
    func getAuthenticationCode(with code: String) {
        viewModel.getAuthentication(with: code) { [weak self] (result) in
            switch result {
            case .success(let accessToken):
                UserDefaultsService.shared.setToken(accessToken.accessToken)
                self?.navigateToRepositories()
                break
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    fileprivate func navigateToRepositories() {
        performSegue(withIdentifier: "presentTabbarController", sender: self)
    }
}



