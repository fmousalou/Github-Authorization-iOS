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
    func exchangeForBearerToken(code: String, clientId: String, redirectUrl: String, clientSecret: String, state: String, completion: @escaping (Swift.Result<String, Error>) -> Void) {
        guard let url = URL(string:"https://github.com/login/oauth/access_token") else {
            return
        }

        let parameters = ["client_id": clientId,
                          "redirect_uri": redirectUrl,
                          "client_secret": clientSecret,
                          "code": code,
                          "state": state] as [String:Any]
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
