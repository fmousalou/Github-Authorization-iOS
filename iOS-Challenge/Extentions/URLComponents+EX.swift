//
//  URLComponents+EX.swift
//  iOS-Challenge
//
//  Created by anna on 11/15/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Foundation

extension URLComponents{
    
    /// Get queryItems as Dictionary
    func getQueryItems() -> [String: String]{
        var dictionary:[String: String] = [:]
        if let queryItems = self.queryItems{
        for item in queryItems{
            dictionary[item.name] = item.value
            }
        }
       return dictionary
    }
    
    /// Set queryItems with Dictionary
    mutating func setQueryItems(with parameters: [String: String]) {
    self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
}
