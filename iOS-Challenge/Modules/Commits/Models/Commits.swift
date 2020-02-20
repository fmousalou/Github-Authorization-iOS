//
//  Commits.swift
//  iOS-Challenge
//
//  Created by erfan on 12/1/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Foundation

struct Commit: Decodable {
    var commit: CommitDetail?
    
    struct CommitDetail: Decodable {
        var message: String?
        var committer: Committer?
        
        struct Committer: Decodable {
            var name: String?
        }
    }
}
