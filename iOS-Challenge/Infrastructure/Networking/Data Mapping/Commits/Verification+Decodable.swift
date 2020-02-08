//
//  Verification+Decodable.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
extension Verification : Decodable {
	enum CodingKeys: String, CodingKey {

		case verified = "verified"
		case reason = "reason"
		case signature = "signature"
		case payload = "payload"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		verified = try values.decodeIfPresent(Bool.self, forKey: .verified)
		reason = try values.decodeIfPresent(String.self, forKey: .reason)
		signature = try values.decodeIfPresent(String.self, forKey: .signature)
		payload = try values.decodeIfPresent(String.self, forKey: .payload)
	}

}
