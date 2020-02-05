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
    func viewWillAppear()
}
protocol AuthorizationViewModelOutput {
    var loginMessage: String { get }
    var loginButtonTitle: String { get }
}

protocol AuthorizationViewModel: AuthorizationViewModelInput, AuthorizationViewModelOutput {
    func addObservers()
    func removeObservers()
}

final class DefaultAuthorizationViewModel: AuthorizationViewModel {
    
    struct Dependency {
        let clientId:String
        let createGitHubAuthorizationLinkUseCase: CreateGitHubAuthorizationLinkUseCase
        let exchangeGithubOAuthTokenToBearerTokenUseCase: ExchangeGithubOAuthTokenToBearerTokenUseCase
        let storeAuthorizedTokenUseCase: StoreAuthorizedTokenUseCase
    }
    
    let dependency: Dependency
    
    init(dependency: Dependency) {
        self.dependency = dependency
        addObservers()
    }
    
    deinit {
        removeObservers()
    }
    
    func addObservers() {
        NotificationCenter.addObserver(self, selector: #selector(recievedToken), notificationName: .recievedTokenFromServer)
    }
    func removeObservers() {
        NotificationCenter.removeObserver(self, name: .recievedTokenFromServer)
    }
    
    @objc func recievedToken(notification: Notification)  {
        guard let token = notification.userInfo?[NotificationObjectKeys.oAuthToken] as? String else { return }
        DispatchQueue.main.async {
            self.exchangeToken(token: token)
        }
    }
    
    private func exchangeToken(token: String) {
        dependency.exchangeGithubOAuthTokenToBearerTokenUseCase.execute(oAuthToken: token) { (result) in
            switch result {
            case .success(let bearerToken):
                let _ = self.dependency.storeAuthorizedTokenUseCase.execute(bearerToken: bearerToken, completion: nil)
            case .failure(let error):
                print(error)
                fatalError()
            }
        }
    }
    
    let loginMessage: String = "Please login with GitHub to continue"
    let loginButtonTitle: String = "Login"
    
    func pressedLoginButton() {
        guard let requestURLString = dependency.createGitHubAuthorizationLinkUseCase.execute(clientId: dependency.clientId),
            let requestURL = URL(string: requestURLString)
            else { fatalError() }
        UIApplication.shared.open(requestURL,
                                  options: [:]) { (result) in
                                    print(result)
        }
    }
    func viewWillAppear() {
        
    }
    
}

