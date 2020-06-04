//
//  User.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: String?
    let company: String?
    let location: String?
    let email: String?
    let bio: String?
    let public_repos: Int?
    let followers: Int?
    let following: Int?
    let avatar_url: URL?
}
