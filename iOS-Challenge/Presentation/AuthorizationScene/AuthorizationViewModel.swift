//
//  AuthorizationViewModel.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit

protocol AuthorizationViewModelInput {
    func pressedLoginButton()
}
protocol AuthorizationViewModelOutput {
    var loginMessage: String { get }
    var loginButtonTitle: String { get }
}

protocol AuthorizationViewModel: AuthorizationViewModelInput, AuthorizationViewModelOutput {}

final class DefaultAuthorizationViewModel: AuthorizationViewModel {
    
    struct Dependency {
        let clientId:String
    }
    
    let dependency: Dependency
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    let loginMessage: String = "Please login with GitHub to continue"
    let loginButtonTitle: String = "Login"
    
    func pressedLoginButton() {
        guard let requestURLString = DefaultCreateGitHubAuthorizationLinkUseCase().execute(clientId: dependency.clientId),
            let requestURL = URL(string: requestURLString)
            else { fatalError() }
        UIApplication.shared.open(requestURL,
                                  options: [:]) { (result) in
                                    print(result)
        }
    }
}

