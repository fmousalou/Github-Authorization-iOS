//
//  OAuthAccessTokenNetwork.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

/// - OAuthAccessTokenRequest
struct OAuthAccessTokenRequest: Encodable {
    let client_id: String?
    let redirect_uri: String?
    let client_secret: String?
    let code: String?
    let state: Int?
}

/// - OAuthAccessTokenResponse
struct OAuthAccessTokenResponse: Decodable {
    let access_token: String?
    let token_type: String?
    let scope: String?
}

/// - OAuthAccessTokenErrorResponse
struct OAuthAccessTokenErrorResponse: Decodable {
    let detail: String?
}

/// - OAuthAuthorizeNetwork
struct OAuthAccessTokenNetwork: BaseRequest {
    typealias RequestType = OAuthAccessTokenRequest
    typealias ResponseType = OAuthAccessTokenResponse
    typealias ErrorType = OAuthAccessTokenErrorResponse
    
    var code: String = ""
    var state: Int = 0
    
    init(code: String, state: Int) {
        self.code = code
        self.state = state
    }
    
    var data: RequestData<OAuthAccessTokenRequest> {
        return RequestData(path: ConstantURLs.core + "login/oauth/access_token",
                           method: HTTPMethod.post,
                           params: OAuthAccessTokenRequest(client_id: ConstantURLs.clientId, redirect_uri: ConstantURLs.redirect_url, client_secret: ConstantURLs.clientSecret, code: code, state: state))
    }
    
}
