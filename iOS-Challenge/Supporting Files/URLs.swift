//
//  URLs.swift
//  iOS-Challenge
//
//  Created by Erfan Andesta on 2/18/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct URLs {
    static let baseURL = "https://github.com"
    static let baseAPIURL = "https://api.github.com"
    static let authorizationURL = URLs.baseURL + "/login/oauth/authorize"
    static let authorizationAccessCodeURL = URLs.baseURL + "/login/oauth/access_token"
    static let searchURL = URLs.baseAPIURL + "/search/repositories"
    static let userURL = URLs.baseAPIURL + "/user"
    static func commitsURL(forOwner owner: String, forRepo repo: String) -> String {
        return URLs.baseAPIURL + "/repos/\(owner)/\(repo)/commits"
    }
}
