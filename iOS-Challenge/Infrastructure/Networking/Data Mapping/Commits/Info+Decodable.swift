//
//  Info+Decodable.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//


import Foundation
extension Info : Decodable {

	enum CodingKeys: String, CodingKey {

		case author = "author"
		case committer = "committer"
		case message = "message"
		case tree = "tree"
		case url = "url"
		case comment_count = "comment_count"
		case verification = "verification"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		author = try values.decodeIfPresent(Author.self, forKey: .author)
		committer = try values.decodeIfPresent(Committer.self, forKey: .committer)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		tree = try values.decodeIfPresent(Tree.self, forKey: .tree)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		comment_count = try values.decodeIfPresent(Int.self, forKey: .comment_count)
		verification = try values.decodeIfPresent(Verification.self, forKey: .verification)
	}

}
