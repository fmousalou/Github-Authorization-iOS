//
//  Owner+Decodable.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/7/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
extension Owner : Decodable
{
    enum CodingKeys: String, CodingKey {
        
        case login = "login"
        case id = "id"
        case node_id = "node_id"
        case avatar_url = "avatar_url"
        case gravatar_id = "gravatar_id"
        case url = "url"
        case html_url = "html_url"
        case followers_url = "followers_url"
        case following_url = "following_url"
        case gists_url = "gists_url"
        case starred_url = "starred_url"
        case subscriptions_url = "subscriptions_url"
        case organizations_url = "organizations_url"
        case repos_url = "repos_url"
        case events_url = "events_url"
        case received_events_url = "received_events_url"
        case type = "type"
        case site_admin = "site_admin"
        case name = "name"
        case company = "company"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        login = try values.decodeIfPresent(String.self, forKey: .login)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        node_id = try values.decodeIfPresent(String.self, forKey: .node_id)
        avatar_url = try values.decodeIfPresent(String.self, forKey: .avatar_url)
        gravatar_id = try values.decodeIfPresent(String.self, forKey: .gravatar_id)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        html_url = try values.decodeIfPresent(String.self, forKey: .html_url)
        followers_url = try values.decodeIfPresent(String.self, forKey: .followers_url)
        following_url = try values.decodeIfPresent(String.self, forKey: .following_url)
        gists_url = try values.decodeIfPresent(String.self, forKey: .gists_url)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        company = try values.decodeIfPresent(String.self, forKey: .company)
        starred_url = try values.decodeIfPresent(String.self, forKey: .starred_url)
        subscriptions_url = try values.decodeIfPresent(String.self, forKey: .subscriptions_url)
        organizations_url = try values.decodeIfPresent(String.self, forKey: .organizations_url)
        repos_url = try values.decodeIfPresent(String.self, forKey: .repos_url)
        events_url = try values.decodeIfPresent(String.self, forKey: .events_url)
        received_events_url = try values.decodeIfPresent(String.self, forKey: .received_events_url)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        site_admin = try values.decodeIfPresent(Bool.self, forKey: .site_admin)
    }
    
}
