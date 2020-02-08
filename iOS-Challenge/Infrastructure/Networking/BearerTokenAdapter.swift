//
//  BearerTokenAdapter.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/8/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Alamofire

class BearerTokenAdapter: RequestAdapter
{
    private var token: String? = nil

    init(bearerTokenRepository: BearerTokenRepository) {
        bearerTokenRepository.fetch { (result) in
            switch result {
            case .success(let newToken): self.token = newToken
            case .failure(_): break
            }
        }
        
    }
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        guard let accessToken = token else { return urlRequest }
        var newRequest = urlRequest
        newRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        return newRequest
    }

}
