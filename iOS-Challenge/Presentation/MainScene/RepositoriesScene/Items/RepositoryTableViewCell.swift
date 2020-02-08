//
//  RepositoryTableViewCell.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/8/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

final class RepositoryTableViewCell: UITableViewCell
{
    static let identifier = "RepositoryTableViewCell"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var watcherLabel: UILabel!
    func fill(with item: RepositoryItemViewModel) {
        nameLabel.text = "Name: \(item.name ?? "")"
        descriptionLabel.text = "Description: \(item.desc ?? "")"
        languageLabel.text = "Language: \(item.language ?? "")"
        watcherLabel.text = "Number of watcher: \(item.watchers ?? 0)"
    }
}
