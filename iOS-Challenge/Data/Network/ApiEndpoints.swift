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
    
    static func commits(for repository: Repository, perPage: Int, pageNumber: Int) -> Endpoint<[Commit]> {
        let queryParams = ["page":pageNumber, "per_page":perPage] as [String : Any]
        let url = repository.commits_url?.replacingOccurrences(of: "{/sha}", with: "") ?? ""
        return Endpoint<[Commit]> (
            baseURLString: url,
            path: nil,
            queryParameters: queryParams)
    }
    
    static func user(with token: String) -> Endpoint<Owner> {
        return Endpoint<Owner>(
            baseURLString:  AppConfigurations().apiBaseURL,
            path: "user",
            method: .get,
            queryParameters: nil,
            headerParamaters: ["Authorization":"Bearer \(token)"])
        
    }
}
