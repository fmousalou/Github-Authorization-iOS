//
//  Commit+Decodable.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//


import Foundation
extension Commit : Decodable {
	enum CodingKeys: String, CodingKey {

		case sha = "sha"
		case node_id = "node_id"
		case commit = "commit"
		case url = "url"
		case html_url = "html_url"
		case comments_url = "comments_url"
		case author = "author"
		case committer = "committer"
		case parents = "parents"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		sha = try values.decodeIfPresent(String.self, forKey: .sha)
		node_id = try values.decodeIfPresent(String.self, forKey: .node_id)
		commit = try values.decodeIfPresent(Info.self, forKey: .commit)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		html_url = try values.decodeIfPresent(String.self, forKey: .html_url)
		comments_url = try values.decodeIfPresent(String.self, forKey: .comments_url)
		author = try values.decodeIfPresent(Author.self, forKey: .author)
		committer = try values.decodeIfPresent(Committer.self, forKey: .committer)
		parents = try values.decodeIfPresent([Parents].self, forKey: .parents)
	}

}
