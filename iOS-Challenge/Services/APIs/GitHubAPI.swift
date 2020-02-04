//
//  GitHubAPIs.swift
//  iOS-Challenge
//
//  Created by anna on 11/13/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Moya

public enum GitHubAPI {
    case search(keyWord:String,sort:String ,order:String,page:String )
}

extension GitHubAPI: TargetType {
    
    public var headers: [String : String]? {
        return HTTPManager.shared.headers
    }
    
    /// The target's base `URL`.
    public var baseURL: URL {
        return HTTPManager.shared.baseUrl
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
            
        case .search(let keyWord,let sort,let order,let page):
            var base = "/search/repositories?"
            
            if keyWord.count > 0 {
                base = base + "q=topic:" + keyWord + "&"
            }
            
            base = base + "sort=" + sort + "&"
            base = base + "order=" + order + "&"
            base = base + "page=" + page
            return base
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    /// Provides stub data for use in testing.
    public var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
    
    /// The type of HTTP task to be performed.
    public var task: Moya.Task {
        switch self {
        default:
            return .requestPlain
        }
        
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    public var validate: Bool {
        return true
    }
}



