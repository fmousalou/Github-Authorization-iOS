//
//  CommitItemViewModel.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/8/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

protocol CommitItemViewModelInput { }
protocol CommitItemViewModelOutput {
    var message: String { get }
    var author: String { get }
    var commitId: String { get }
}
protocol CommitItemViewModel: CommitItemViewModelInput, CommitItemViewModelOutput {
    var commit: Commit { get }
}

final class DefaultCommitItemViewModel: CommitItemViewModel
{
    var commit: Commit
    
    var message: String
    
    var author: String
    
    var commitId: String
    
    init(commit: Commit) {
        self.commit = commit
        self.commitId = commit.sha ?? ""
        self.author = commit.author?.login ?? ""
        self.message = commit.commit?.message ?? ""
    }
}
