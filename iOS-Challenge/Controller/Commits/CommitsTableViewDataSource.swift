//
//  CommitsTableViewDataSource.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/5/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class CommitsTableViewDataSource: NSObject, UITableViewDataSource {
    
    var commits = [Commit]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Make custom class
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = commits[indexPath.row].committer?.name
        cell.detailTextLabel?.text = commits[indexPath.row].message
        return cell
    }
}
