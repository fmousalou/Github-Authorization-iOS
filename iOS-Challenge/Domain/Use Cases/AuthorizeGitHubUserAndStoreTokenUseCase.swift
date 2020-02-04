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
    func execute(completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable?
}

protocol ConvertGithubOAuthTokenToBearerTokenUseCase
{
    func execute(oAuthToken: String, completion: @escaping (Result<String, Error>) -> Void) -> Cancellable?
}

public class DefaultCreateGitHubAuthorizationLinkUseCase: CreateGitHubAuthorizationLinkUseCase
{
    func execute(clientId: String) -> String? {
        let urlString = "https://github.com/login/oauth/authorize"
        guard var urlComponents = URLComponents(string: urlString) else { return nil }
        let queryParams: [String:String] =
            ["client_id": clientId,
             "redirect_uri": "challenge://app/callback",
             "scope": "repo private_repo user user_email",
             "state": "0"]
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
    func execute(completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable? {
        fatalError()
    }
}

public class DefaultConvertGithubOAuthTokenToBearerTokenUseCase: ConvertGithubOAuthTokenToBearerTokenUseCase
{
    func execute(oAuthToken: String, completion: @escaping (Result<String, Error>) -> Void) -> Cancellable? {
        fatalError()
    }
}
