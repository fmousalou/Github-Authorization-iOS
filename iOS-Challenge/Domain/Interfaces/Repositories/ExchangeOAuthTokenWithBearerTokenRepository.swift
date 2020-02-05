//
//  ExchangeOAuthTokenWithBearerToken.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

protocol ExchangeOAuthTokenWithBearerTokenRepository {

    func exchangeForBearerToken(code: String,
                                clientId: String,
                                redirectUrl: String,
                                clientSecret: String,
                                state: String,
                                completion: @escaping (Result<String, Error>) -> Void)
}
