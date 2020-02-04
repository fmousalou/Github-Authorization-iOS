//
//  AuthorizationSceneDIContainer.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

final class AuthorizationSceneDIContainer
{
    struct Dependency {
        let clientId: String
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }

    //MARK: - Use Cases
    //MARK: - View Controllers
    func makeAuthorizationViewController() -> AuthorizationViewController {
        AuthorizationViewController.create(with: makeAuthorizationViewModel())
    }
    
    private func makeAuthorizationViewModel() -> AuthorizationViewModel {
        return DefaultAuthorizationViewModel(dependency: DefaultAuthorizationViewModel.Dependency(clientId: dependency.clientId))
    }
}
