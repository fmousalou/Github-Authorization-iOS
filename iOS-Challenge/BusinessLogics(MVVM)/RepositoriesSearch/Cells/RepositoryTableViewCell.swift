//
//  RepositoryTableViewCell.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repoName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(data: SearchRepositoriesItemResponse) {
        repoName.text = data.full_name ?? ""
    }

}
