//
//  Authorization.swift
//  iOS-Challenge
//
//  Created by Erfan Andesta on 2/18/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct Authorization {
    static var parameters: [String: Any] = [
        "client_id": clientId,
        "redirect_uri": redirect_url,
        "scope": "repo user",
        "client_secret": clientSecret,
        "state": 0
    ]
    static func setCode(code: String) {
        parameters["code"] = code
        parameters["client_secret"] = clientSecret
        parameters["scope"] = nil
    }
    static func resetCode() {
        parameters["code"] = nil
        parameters["client_secret"] = nil
        parameters["scope"] = "repo user"
    }
    private static let clientId = "04860a64b85b7438bf91"
    private static let clientSecret = "13342aaf3eb01b5498fc16b1bad90e1ab0e64a28"
    private static let redirect_url = "challenge://app/callback"
}
