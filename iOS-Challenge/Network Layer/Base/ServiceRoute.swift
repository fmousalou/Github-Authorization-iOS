//
//  ServiceRoute.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 1/28/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation

enum LoginRoute:String{
    case oathLogin = "/login/oauth/authorize"
    var path:String{
        return BaseURL.githubOath.rawValue + self.rawValue
    }
}
enum UserRoute: String {
    case user = "/user"
    var path: String {
        return BaseURL.githubBaseUrl.rawValue + self.rawValue
    }
}

enum SearchRoute:String {
    case repo = "/search/repositories"
    var path:String{
        return BaseURL.githubBaseUrl.rawValue + self.rawValue
    }
}

enum Repos:String{
    case Commits = "/repos"
    var path:String{
        return BaseURL.githubBaseUrl.rawValue + self.rawValue
    }
}
