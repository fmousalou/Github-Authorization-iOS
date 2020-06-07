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
@testable import iOS_Challenge

class RepoVieModelTest: XCTestCase {
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


