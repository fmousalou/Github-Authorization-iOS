//
//  iOS_ChallengeTests.swift
//  iOS-ChallengeTests
//
//  Created by Farshad Mousalou on 1/28/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import XCTest
import SwiftyJSON
import Quick
import Nimble
import Nimble_Snapshots
@testable import iOS_Challenge

class iOS_ChallengeTests: XCTestCase {
    
    

    func testRepoViewModel() { // Without Library
        //TODO: Make it dynamic
        //Read sample json from bundle
        let path = Bundle.main.path(forResource: "GitRepo", ofType: "json")
        let jsonData = try! String(contentsOfFile: path!).data(using: .utf8)!
        let repos = JSON(jsonData)["items"].array
        XCTAssertNotNil(repos)
        // test viewmodel
        let repoViewmodel = ReposViewModel()
        repoViewmodel.processFetched(repos: repos!)
        XCTAssert(repoViewmodel.repoViewModels.count > 0)
        let alamofireRepo = repoViewmodel.repoViewModels.first
        XCTAssertNotNil(alamofireRepo)
        XCTAssertEqual(alamofireRepo?.nameText, "Alamofire")
        XCTAssertNotNil(alamofireRepo?.commitsURL)
        XCTAssertNotNil(alamofireRepo?.imageUrl)
    }
}

class CommitsDatasourceTest: QuickSpec {
    
    override func spec() {
        
        var myDelegateDatasource: CommitsTableViewDataSource!
        var tableView: UITableView!
        
        describe("MyDelegateDatasource") {
            
            beforeEach {
                let data = ["Rodrigo", "Cavalcante", "Testing", "Delegate", "Datasource"]
                myDelegateDatasource = MyDelegateDatasource()
                
                myDelegateDatasource.data = data
                
                tableView = UITableView()
                tableView.register(UITableViewCell.self,
                                   forCellReuseIdentifier: "Cell")
                tableView.dataSource = myDelegateDatasource
                tableView.delegate = myDelegateDatasource
            }
            
            //MARK: Datasource
            
            it("should return the right number of rows") {
                expect(myDelegateDatasource.tableView(tableView, numberOfRowsInSection: 0)) == 5
            }
            
            it("should return the right number of sections") {
                expect(myDelegateDatasource.numberOfSections(in: tableView)) == 1
            }
        }
    }
}
