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
}

extension GithubService: TargetType {
    var baseURL: URL {
        return URL(string: "https://github.com")!
    }
    
    var path: String {
        switch self {
        case .authenticate:
            return "/login/oauth/access_token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .authenticate:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .authenticate(let code):
            return .requestParameters(parameters: ["client_id": clientId,
                                                   "redirect_uri": redirect_url,
                                                   "client_secret": clientSecret,
                                                   "code": code,
                                                   "state": 0],
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let header = ["Content-Type" : "application/json"]
        switch self {
        case .authenticate:
            return header
        }
    }
}
