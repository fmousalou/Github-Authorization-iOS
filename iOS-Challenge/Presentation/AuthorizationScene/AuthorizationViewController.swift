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
    fileprivate var mainSceneDIContainer:MainSceneDIContainer!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = viewModel.loginMessage
        bind(to: viewModel)
    }
    
    @IBAction func pressedLoginButton(_ sender: Any?) {
        viewModel.pressedLoginButton()
    }
    
    func bind(to viewModel: AuthorizationViewModel) {
        viewModel.route.observe(on: self) { [weak self] route in
            self?.handle(route)
        }
    }
    
    func handle(_ route: AuthorizationViewModelRoute) {
        switch route {
        case .initial: break
        case .showMainScene:
            let viewController = RepositoriesViewController.create(with: mainSceneDIContainer.makeRepositoriesViewModel(), repositoryListFactory: mainSceneDIContainer)
            navigationController?.setViewControllers([viewController], animated: true)
        }
    }
}
//MARK: - create method
extension AuthorizationViewController
{
    static func create(with viewModel:AuthorizationViewModel, mainSceneDIContainer: MainSceneDIContainer) -> AuthorizationViewController {
        let viewController = AuthorizationViewController.instantiateViewController()
        viewController.viewModel = viewModel
        viewController.mainSceneDIContainer = mainSceneDIContainer
        return viewController
    }
}


protocol AuthorizationRouteFactory {
    func makeMainView() -> RepositoriesViewController
}
