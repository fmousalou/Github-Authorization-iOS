//
//  GithubService.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Moya

enum GithubService {
    case authenticate(code: String)
    case userInfo
}

extension GithubService: TargetType {
    
    var baseURL: URL {
        switch self {
        case .authenticate:
            return URL(string: "https://github.com")!
        case .userInfo:
             return URL(string: "https://api.github.com")!
        }
    }
    
    var path: String {
        switch self {
        case .authenticate:
            return "/login/oauth/access_token"
        case .userInfo:
            return "/user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .authenticate:
            return .post
        case .userInfo:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .authenticate(let code):
            let params = ["client_id": clientId,
                          "redirect_uri": redirect_url,
                          "client_secret": clientSecret,
                          "code": code,
                          "state": 0] as [String : Any]
            return .requestParameters(parameters: params,
                                      encoding: JSONEncoding.prettyPrinted)
        case .userInfo:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let header = ["Accept" : "application/json"]
        switch self {
        case .authenticate, .userInfo:
            return header
        }
    }
}

extension GithubService: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .bearer
    }
}
