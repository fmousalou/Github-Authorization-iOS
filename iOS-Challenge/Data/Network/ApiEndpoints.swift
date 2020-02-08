//
//  ApiEndpoints.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/7/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import Alamofire

struct APIEndpoints {
    
    static func exchangeToken(clientId: String,
    redirectUrl: String,
    clientSecret: String,
    state: String,
    oAtuthToken: String) -> Endpoint<AccessTokenResponse> {
        
        let parameters = ["client_id": clientId,
                          "redirect_uri": redirectUrl,
                          "client_secret": clientSecret,
                          "code": oAtuthToken,
                          "state": state] as [String:Any]
        let endpoint = Endpoint<AccessTokenResponse>(
            baseURLString: "https://github.com/",
            path: "login/oauth/access_token",
            method: .post,
            queryParameters: [:],
            headerParamaters: ["Accept":"application/json"],
            bodyParamaters: parameters)
        
        return endpoint
    }
    
    static func repositories(with searchTerm:String, page:Int, perPage: Int = 10) -> Endpoint<RepositorySearchResponseModel> {
        let queryParams = ["q":searchTerm, "page":page, "per_page":perPage] as [String : Any]
        return Endpoint<RepositorySearchResponseModel>(
            baseURLString: AppConfigurations().apiBaseURL,
            path: "search/repositories",
            method: .get,
            queryParameters: queryParams,
            headerParamaters: [:])
    }
}
