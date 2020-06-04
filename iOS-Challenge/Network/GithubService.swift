//
//  GithubService.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Moya

struct committer {
    var ownerName: String?
    var projectName: String?
}

enum GithubService {
    case authenticate(code: String)
    case userInfo
    case search(subject: String)
    case commits(commitPath: String)
}

extension GithubService: TargetType {
    
    var baseURL: URL {
        switch self {
        case .authenticate:
            return URL(string: "https://github.com")!
        case .userInfo, .search, .commits:
             return URL(string: "https://api.github.com")!
        }
    }
    
    var path: String {
        switch self {
        case .authenticate:
            return "/login/oauth/access_token"
        case .userInfo:
            return "/user"
        case .search:
            return "/search/repositories"
        case .commits(let commitPath):
            return commitPath
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .authenticate:
            return .post
        case .userInfo, .search, .commits:
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
        case .userInfo, .commits:
            return .requestPlain
        case .search(let q):
            return .requestParameters(parameters: ["q" : q],
                                      encoding: URLEncoding())
        }
    }
    
    var headers: [String : String]? {
        let header = ["Accept" : "application/json"]
        switch self {
        case .authenticate, .userInfo, .search, .commits:
            return header
        }
    }
}

extension GithubService: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .bearer
    }
}
