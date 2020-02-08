//
//  CommitTableViewCell.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/8/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class CommitTableViewCell: UITableViewCell {
    static let identifier  = "CommitTableViewCell"

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var commitIdLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    func fill(with viewModel: CommitItemViewModel) {
        messageLabel.text = viewModel.message
        commitIdLabel.text = viewModel.commitId
        authorLabel.text = viewModel.author
    }
}
