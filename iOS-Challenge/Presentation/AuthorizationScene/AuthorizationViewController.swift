//
//  AuthorizationViewController.swift
//  iOS-Challenge
//
//  Created by Farshad Mousalou on 1/28/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

final class AuthorizationViewController: UIViewController, StoryboardInstantiable
{
    fileprivate var viewModel: AuthorizationViewModel!
    
    @IBOutlet weak var accessTokenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accessTokenLabel.text = viewModel.loginMessage
    }
    
    @IBAction func loginDidPress(_ sender: Any?) {
        viewModel.pressedLoginButton()
    }
}
//MARK: - create method
extension AuthorizationViewController
{
    static func create(with viewModel:AuthorizationViewModel) -> AuthorizationViewController {
        let viewController = AuthorizationViewController.instantiateViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}

