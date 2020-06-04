//
//  Commit.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct Commit: Decodable {
    let committer: Committer?
    let message: String?
    
    private enum CodingKeys: String, CodingKey {
        case message, committer
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode(String.self, forKey: .message)
        committer = try container.decode(Committer.self, forKey: .committer)
    }
}

struct Committer: Decodable {
    let name: String?
    let email: String?
    let date: String?
}
