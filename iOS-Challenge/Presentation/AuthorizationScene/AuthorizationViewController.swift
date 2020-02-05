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
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = viewModel.loginMessage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    @IBAction func pressedLoginButton(_ sender: Any?) {
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

