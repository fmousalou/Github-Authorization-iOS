//
//  CommitListTableVC.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 2/1/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit

class CommitListTblVc: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    func setupUI(){
        self.tableView.register( UINib(nibName: "CommitsCell", bundle: nil), forCellReuseIdentifier: "CommitsCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommitCell") as? CommitCell
//               if let data = self.vm.dataSource {
//                   let cellData = data[indexPath.row]
                   cell?.config(name: "Sd", User: "sdsdsdads", date: "sdasdasad")
//               }
               return cell ?? UITableViewCell()
    }
    
}
