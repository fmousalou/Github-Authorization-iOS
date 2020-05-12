//
//  CommitCell.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 2/1/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit

class CommitCell: UITableViewCell {
    
    @IBOutlet weak var commitNameLbl: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var commitDateLabel: UILabel!
    
    func config(name:String , User:String, date:String){
        self.commitNameLbl.text = name
        self.userLabel.text = User
        self.commitDateLabel.text = date
    }
}
