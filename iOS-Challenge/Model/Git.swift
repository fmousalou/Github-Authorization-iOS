//
//  Git.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation


// Model
struct GitRepo: Codable {
    var name: String?
    var stars: Int?
    var owner: GitOwner?
    
    private enum CodingKeys: String, CodingKey {
        case
        name,
        stars = "stargazers_count",
        owner
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        stars = try container.decode(Int.self, forKey: .stars)
        owner = try container.decode(GitOwner.self, forKey: .owner)
    }
}
struct GitOwner: Codable {
    var avatar_url: URL?
}
