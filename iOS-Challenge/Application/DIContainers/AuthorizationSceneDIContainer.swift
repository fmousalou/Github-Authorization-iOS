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
        let redirectUrl: String
        let clientSecret: String
        let state: String
        let scopes: String
        let keychainServiceKey: String
        let tokenKey: String
        let apiDataTransferService: DataTransferService
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }

    //MARK: - Use Cases
    //MARK: - View Controllers
    func makeAuthorizationViewController() -> AuthorizationViewController {
        AuthorizationViewController.create(with: makeAuthorizationViewModel(), mainSceneDIContainer: AppDIContainer().makeMainSceneDIContainer())
    }
    
    private func makeAuthorizationViewModel() -> AuthorizationViewModel {
        return DefaultAuthorizationViewModel(
            dependency:
            DefaultAuthorizationViewModel.Dependency(
                clientId: dependency.clientId,
                createGitHubAuthorizationLinkUseCase: makeCreateGitHubAuthorizationLinkUseCase(),
                exchangeGithubOAuthTokenToBearerTokenUseCase: makeExchangeGithubOAuthTokenToBearerTokenUseCase(),
                storeAuthorizedTokenUseCase: makeStoreAuthorizedTokenUseCase()))
    }
    
    private func makeCreateGitHubAuthorizationLinkUseCase () -> CreateGitHubAuthorizationLinkUseCase{
        return DefaultCreateGitHubAuthorizationLinkUseCase(
            dependency: DefaultCreateGitHubAuthorizationLinkUseCase.Dependency(
            reduirectURL: dependency.redirectUrl,
            scopes: dependency.scopes,
            state: dependency.state))
    }
    
    private func makeExchangeGithubOAuthTokenToBearerTokenUseCase() -> ExchangeGithubOAuthTokenToBearerTokenUseCase {
        return DefaultExchangeGithubOAuthTokenToBearerTokenUseCase(dependency: DefaultExchangeGithubOAuthTokenToBearerTokenUseCase.Dependency(
            clientId: dependency.clientId,
            redirectUrl: dependency.redirectUrl,
            clientSecret: dependency.clientSecret,
            state: dependency.state,
            exchangeOAuthTokenWithBearerTokenRepository: makeExchangeOAuthTokenWithBearerTokenRepository()))
    }
    
    private func makeStoreAuthorizedTokenUseCase() -> StoreAuthorizedTokenUseCase {
        return DefaultStoreAuthorizedTokenUseCase(dependency: DefaultStoreAuthorizedTokenUseCase.Dependency(repository: makeBearerTokenRepository()))
    }
    
    private func makeExchangeOAuthTokenWithBearerTokenRepository() -> ExchangeOAuthTokenWithBearerTokenRepository{
        return DefaultExchangeOAuthTokenWithBearerTokenRepository(dependency: DefaultExchangeOAuthTokenWithBearerTokenRepository.Dependency(
            clientId: dependency.clientId,
            redirectUrl: dependency.redirectUrl,
            clientSecret: dependency.clientSecret,
            state: dependency.state,
            dataTransferService: dependency.apiDataTransferService))
    }
    
    private func makeBearerTokenRepository() -> BearerTokenRepository {
        return KeyChainBearerTokenRepository(dependency: KeyChainBearerTokenRepository.Dependency(serviceKey: dependency.keychainServiceKey, tokenKey: dependency.tokenKey))
    }
}
