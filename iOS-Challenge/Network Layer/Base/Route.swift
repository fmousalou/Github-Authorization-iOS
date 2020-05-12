//
//  Route.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 1/28/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation

enum BaseURL: String {
    case githubBaseUrl = "https://api.github.com"
    case githubOath = "https://github.com"
}

enum Route {
    case UserServicesRoute(UserRoute)
    case LoginServices(LoginRoute)
    case SearchServices(SearchRoute)
    case RepoServices(Repos)
}

extension Route {
    var url: String {
        switch self {
        case .UserServicesRoute(let userRoute):
            return userRoute.path
        case .LoginServices(let LoginRoute):
            return LoginRoute.path
        case .SearchServices(let searchRoute):
            return searchRoute.path
        case .RepoServices(let RepoRoute):
            return RepoRoute.path
        }
    }
}
