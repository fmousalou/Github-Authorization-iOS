//
//  AuthorizeGitHubUser.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

protocol CreateGitHubAuthorizationLinkUseCase
{
    func execute(clientId: String) -> String?
}

protocol StoreAuthorizedTokenUseCase
{
    func execute(bearerToken: String, completion: ((Result<Bool, Error>) -> Void)?)
}

protocol ExchangeGithubOAuthTokenToBearerTokenUseCase
{
    func execute(oAuthToken: String, completion: @escaping (Result<String, Error>) -> Void)
}

public class DefaultCreateGitHubAuthorizationLinkUseCase: CreateGitHubAuthorizationLinkUseCase
{
    struct Dependency {
        let reduirectURL: String
        let scopes: String
        let state: String
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }

    
    func execute(clientId: String) -> String? {
        let urlString = "https://github.com/login/oauth/authorize"
        guard var urlComponents = URLComponents(string: urlString) else { return nil }
        let queryParams: [String:String] =
            ["client_id": clientId,
             "redirect_uri": dependency.reduirectURL,
             "scope": dependency.scopes,
             "state": dependency.state]
        var queryItems = [URLQueryItem]()
        for (key, param) in queryParams {
            let queryItem = URLQueryItem(name: key, value: param)
            queryItems.append(queryItem)
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url?.absoluteString
    }
}

public class DefaultStoreAuthorizedTokenUseCase: StoreAuthorizedTokenUseCase
{
    struct Dependency {
        let repository: BearerTokenRepository
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }

    
    func execute(bearerToken: String, completion: ((Result<Bool, Error>) -> Void)?) {
        dependency.repository.save(token: bearerToken, completion: completion)
    }
}

public class DefaultExchangeGithubOAuthTokenToBearerTokenUseCase: ExchangeGithubOAuthTokenToBearerTokenUseCase
{
    struct Dependency {
        let clientId: String
        let redirectUrl: String
        let clientSecret: String
        let state: String
        let exchangeOAuthTokenWithBearerTokenRepository: ExchangeOAuthTokenWithBearerTokenRepository
    }
    
    let dependency: Dependency
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    func execute(oAuthToken: String, completion: @escaping (Result<String, Error>) -> Void)
    {
        dependency.exchangeOAuthTokenWithBearerTokenRepository.exchangeForBearerToken(
            oAtuthToken: oAuthToken,
            completion: completion)
    }
}
