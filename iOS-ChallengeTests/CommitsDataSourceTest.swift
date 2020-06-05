//
//  File.swift
//  iOS-ChallengeTests
//
//  Created by iMamad on 6/5/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import XCTest
import SwiftyJSON
import Quick
import Nimble
@testable import iOS_Challenge

class CommitsDatasourceTest: QuickSpec {
    
    override func spec() {
        var commitsDataSource: CommitsTableViewDataSource!
        var commitsController: CommitsController!
        var tableView: UITableView!
        
        describe("commitsDataSource") {
            
            // Prepare
            beforeEach {
                let path = Bundle.main.path(forResource: "Commits", ofType: "json")
                let jsonData = try! String(contentsOfFile: path!).data(using: .utf8)!
                let commits = JSON(jsonData).array
                
                commitsController = CommitsController(url: "")
                commitsController.processFetched(jsonCommits: commits!)
                commitsDataSource = commitsController.dataSource
                
                tableView = UITableView()
                tableView.register(UITableViewCell.self,
                                   forCellReuseIdentifier: "Cell")
                tableView.dataSource = commitsController.dataSource
                tableView.delegate = commitsController
            }
            
            // Start DataSource Test
            it("should return the right number of rows") {
                expect(commitsDataSource.tableView(tableView, numberOfRowsInSection: 0)) == commitsDataSource.commits.count
            }
            
            it("should return the right number of sections") {
                expect(commitsDataSource.numberOfSections(in: tableView)) == 1
            }
        }
    }
}
