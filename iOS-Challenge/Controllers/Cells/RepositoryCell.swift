//
//  RepositoryCell.swift
//  iOS-Challenge
//
//  Created by anna on 11/16/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import UIKit
import Kingfisher

class RepositoryCell: UITableViewCell {

    @IBOutlet var repositoryImage: UIImageView!
    @IBOutlet var repositoryTitle: UILabel!
    @IBOutlet var repositoryDescription: UILabel!
    
    private var item:Item?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configur(item:Item){
        self.item = item
        if let ownerAvatar = item.owner?.avatar_url,let url = URL(string: ownerAvatar)  {
         
         repositoryImage.kf.setImage(with: url)
                  
        }
        repositoryTitle.text       = item.full_name ?? ""
        repositoryDescription.text = item.description
    }

}
