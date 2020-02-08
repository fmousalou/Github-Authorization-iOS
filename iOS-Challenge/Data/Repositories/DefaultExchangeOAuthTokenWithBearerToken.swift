//
//  DefaultExchangeOAuthTokenWithBearerToken.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import Alamofire


final class DefaultExchangeOAuthTokenWithBearerTokenRepository: ExchangeOAuthTokenWithBearerTokenRepository
{
    struct Dependency {
        let clientId: String
        let redirectUrl: String
        let clientSecret: String
        let state: String
        let dataTransferService: DataTransferService
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    func exchangeForBearerToken(oAtuthToken: String, completion: @escaping (Swift.Result<String, Error>) -> Void) {
        
    let endpoint =  APIEndpoints.exchangeToken(
        clientId: dependency.clientId,
        redirectUrl: dependency.redirectUrl,
        clientSecret: dependency.clientSecret,
        state: dependency.state,
        oAtuthToken: oAtuthToken)
        
        dependency.dataTransferService.request(with: endpoint)
        { (result: Swift.Result<AccessTokenResponse, Error>) in
            switch result {
            case .success(let accessToken):
                DispatchQueue.main.async { completion(Swift.Result.success(accessToken.accessToken ?? "")) }
            case .failure(let error):
                DispatchQueue.main.async { completion(Swift.Result.failure(error)) }
            }

        }
    }
}
