//
//  GitHubAPIs.swift
//  iOS-Challenge
//
//  Created by anna on 11/13/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Moya

public enum GitHubAPI {
    case login(code:String)
    case search(keyWord:String,sort:String ,order:String,page:String)
    case getUserProfil
    //    case updateUserProfile
}

extension GitHubAPI: TargetType {
    
    public var headers: [String : String]? {
        return HTTPManager.shared.headers
    }
    
    /// The target's base `URL`.
    public var baseURL: URL {
        switch self {
                   
        case .login( _):
            return URL(string: "https://github.com")!
        default:
            return HTTPManager.shared.baseUrl
        }
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
            
        case .login( let code):
            var base = "/login/oauth/access_token?"
            
             base = base + "client_id=\(clientId)"
             base = base + "&code=\(code)"
             base = base + "&client_secret=\(clientSecret)"
             base = base + "&redirect_uri=\(redirectURL)"
             base = base + "&state=\(state)"
            return base
       
        
        case .search(let keyWord,let sort,let order,let page):
        var base = "/search/repositories?"
        
        base = base + "q=topic:" + keyWord
        
        if sort.count > 0 {
            base = base + "&" + "sort=" + sort
        }
        
        if order.count > 0 {
            base = base + "&" + "order=" + order
        }
        
        if page.compare("0") != .orderedSame {
            base = base + "&" + "page=" + page
        }
        return base
        
        case .getUserProfil:
        return "/user"
        
        }
        
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
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
           
//            case .login(let code):
//            var params = [String: Any]()
//        
//               return requestPlain
        default:
            return .requestPlain
        }
        
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    public var validate: Bool {
        return true
    }
}



