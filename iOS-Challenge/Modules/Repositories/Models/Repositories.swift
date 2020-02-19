//
//  Repositories.swift
//  iOS-Challenge
//
//  Created by Erfan Andesta on 2/19/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct GithubRepo: Decodable {
    var name: String?
    var owner: RepoOwner?
}
struct RepoOwner: Decodable {
    var login: String?
}
struct GithubRepositories: Decodable {
    var items: [GithubRepo]
}
