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
    var commitsURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case
        stars = "stargazers_count",
        commitsURL = "commits_url",
        name,
        owner
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        stars = try container.decode(Int.self, forKey: .stars)
        owner = try container.decode(GitOwner.self, forKey: .owner)
        commitsURL = try container.decode(String.self, forKey: .commitsURL)
    }
}
struct GitOwner: Codable {
    var avatar_url: URL?
}


