//
//  Search.swift
//  iOS-Challenge
//
//  Created by Erfan Andesta on 2/19/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct Search {
    static var parameters: [String: Any] = [
        "q": searchQuery,
    ]
    static func setQuery(query: String) {
        parameters["q"] = query
    }
    private static let searchQuery = ""
}
