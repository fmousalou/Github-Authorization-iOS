//
//  ServerError.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

enum ServerError: Error {
    case serverError(msg: String)
}

extension ServerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .serverError(let msg):
            return NSLocalizedString(msg, comment: "")
        }
    }
}
