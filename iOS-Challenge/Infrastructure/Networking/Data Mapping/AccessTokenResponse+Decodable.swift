//
//  AccessTokenResponse.swift
//  iOS-Challenge
//
//  Created by Farshad Mousalou on 2/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

extension AccessTokenResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope = "scope"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        tokenType = try values.decodeIfPresent(String.self, forKey: .tokenType)
        scope = try values.decodeIfPresent(String.self, forKey: .scope)
    }
}
