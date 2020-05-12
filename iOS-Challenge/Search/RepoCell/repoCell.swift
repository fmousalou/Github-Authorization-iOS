//
//  repoCell.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 1/30/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import UIKit
class RepoCell: UITableViewCell {
    
    @IBOutlet weak var RepoNameLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var RepoFullName: UILabel!
    @IBOutlet weak var RepoStarsCountLbl: UILabel!
    
    
    func config(name: String, lang:String, Fullname:String, Star:Int){
        self.RepoNameLbl.text = name
        self.languageLbl.text = lang
        self.RepoFullName.text = Fullname
        self.RepoStarsCountLbl.text = String(Star).threeSeperate()
    }
    
    
}
