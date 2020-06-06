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
    case search(subject: String)
    case commits(commitPath: String)
    case update(user: User)
}

extension GithubService: TargetType {
    
    var baseURL: URL {
        switch self {
        case .authenticate:
            return URL(string: "https://github.com")!
        case .userInfo, .search, .commits, .update:
             return URL(string: "https://api.github.com")!
        }
    }
    
    var path: String {
        switch self {
        case .authenticate:
            return "/login/oauth/access_token"
        case .userInfo, .update:
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
        case .update:
            return .patch
        }
    }
    
    var sampleData: Data {
        //TODO: Do it
        return Data()
    }
    
    var task: Task {
        switch self {
        case .authenticate(let code):
            let secrets = Secrets()
            let params = ["client_id": secrets.clientID,
                          "redirect_uri": secrets.redirect_url,
                          "client_secret": secrets.clientSecret,
                          "code": code,
                          "state": 0] as Params
            return .requestParameters(parameters: params,
                                      encoding: JSONEncoding.prettyPrinted)
        case .userInfo, .commits:
            return .requestPlain
        case .search(let q):
            return .requestParameters(parameters: ["q" : q],
                                      encoding: URLEncoding())
        case .update(let user):
            // TODO: Solve force unwraps
            let params = ["name": user.name!,
                          "company": user.company!,
                          "location": user.location!,
                          "bio": user.bio!] as Params
            return .requestParameters(parameters: params,
                                      encoding: JSONEncoding.prettyPrinted)
        }
    }
    
    var headers: [String : String]? {
        let header = ["Accept" : "application/json"]
        switch self {
        case .authenticate, .userInfo, .search, .commits, .update:
            return header
        }
    }
}

extension GithubService: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .bearer
    }
}


