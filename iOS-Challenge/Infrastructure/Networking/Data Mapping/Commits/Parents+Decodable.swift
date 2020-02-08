//
//  Parents+Decodable.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

extension Parents : Decodable {
	enum CodingKeys: String, CodingKey {

		case sha = "sha"
		case url = "url"
		case html_url = "html_url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		sha = try values.decodeIfPresent(String.self, forKey: .sha)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		html_url = try values.decodeIfPresent(String.self, forKey: .html_url)
	}

}
