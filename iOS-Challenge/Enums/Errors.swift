//
//  Errors.swift
//  iOS-Challenge
//
//  Created by anna on 11/15/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Foundation

enum ChallengeError: Swift.Error {
    
    var localizedDescription: String {
        switch self {
        case .response(let error):
            switch error {
            case .mappingFailed: return "Failed to map object to target type"
            case .invalidJSON: return "Invalid json"
            case .unknown: return "An unknown error occurred"
            }
        }
    }
    
    case response(ResponseError)
    enum ResponseError {
        case invalidJSON
        case mappingFailed
        case unknown
    }
}

struct ResponseError: Swift.Error {
    var message: String!
    var statusCode: Int!
    var validationErrors: [ValidationError]?
    
    init(message: String, statusCode: Int, validationError: [ValidationError]) {
        self.message = message
        self.statusCode = statusCode
        self.validationErrors = validationError
    }
}
