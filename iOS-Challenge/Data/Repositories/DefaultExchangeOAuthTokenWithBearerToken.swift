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
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    func exchangeForBearerToken(oAtuthToken: String, completion: @escaping (Swift.Result<String, Error>) -> Void) {
        guard let url = URL(string:"https://github.com/login/oauth/access_token") else {
            return
        }
        
        let parameters = ["client_id": dependency.clientId,
                          "redirect_uri": dependency.redirectUrl,
                          "client_secret": dependency.clientSecret,
                          "code": oAtuthToken,
                          "state": dependency.state] as [String:Any]
        Alamofire.request(url, method: .post,
                          parameters: parameters, encoding: JSONEncoding.prettyPrinted,
                          headers: ["Accept":"application/json"])
            .validate()
            .responseDecodable { (response : DataResponse<AccessTokenResponse>) in
                switch response.result {
                case .success(let accessToken):
                    
                    DispatchQueue.main.async { completion(Swift.Result.success(accessToken.accessToken ?? "")) }
                case .failure(let error):
                    DispatchQueue.main.async { completion(Swift.Result.failure(error)) }
                }
        }
    }
}
