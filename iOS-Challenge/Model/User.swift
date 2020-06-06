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
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//        company = try container.decode(String.self, forKey: .company)
//        location = try container.decode(String.self, forKey: .location)
//        email = try container.decode(String.self, forKey: .email)
//        bio = try container.decode(String.self, forKey: .bio)
//        public_repos = try container.decode(Int.self, forKey: .public_repos)
//        followers = try container.decode(Int.self, forKey: .followers)
//        following = try container.decode(Int.self, forKey: .following)
//        avatar_url = try container.decode(URL.self, forKey: .location)
//    }
//
//    private enum CodingKeys: String, CodingKey {
//        case
//        name,
//        company,
//        location,
//        email,
//        bio,
//        public_repos,
//        followers,
//        following,
//        avatar_url
//    }
//
    init() {
//        let iMamad = User(name: "iMamad",
//                     company: "Kabok",
//                     location: "Tehran/Iran",
//                     email: nil,
//                     bio: "iOS developer.\r\nReally into Cumputer science.\r\nHave passion in learning and teaching.",
//                     public_repos: nil,
//                     followers: nil,
//                     following: nil,
//                     avatar_url: nil)
        name = "iMamad"
        company = "Kabok"
        location = "Tehran/Iran"
        email = nil
        bio = "iOS developer.\r\nReally into Cumputer science.\r\nHave passion in learning and teaching."
        public_repos = nil
        followers = nil
        following = nil
        avatar_url = nil
    }
    
    
}
