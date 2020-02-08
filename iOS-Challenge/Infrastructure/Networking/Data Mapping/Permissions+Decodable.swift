//
//  Permissions+Decodable.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/7/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

extension Permissions: Decodable
{
    enum CodingKeys: String, CodingKey {
        
        case admin = "admin"
        case push = "push"
        case pull = "pull"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        admin = try values.decodeIfPresent(Bool.self, forKey: .admin)
        push = try values.decodeIfPresent(Bool.self, forKey: .push)
        pull = try values.decodeIfPresent(Bool.self, forKey: .pull)
    }
}
