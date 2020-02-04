//
//  Sort&Order.swift
//  iOS-Challenge
//
//  Created by anna on 11/16/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Foundation

enum Sort:String {
    case stars            = "stars"
    case forks            = "forks"
    case helpWantedIssues = "help-wanted-issues"
    case updated          = "updated"
    case none             = "none"
}

enum Order:String {
    case desc            = "desc"
    case asc             = "asc"
}
