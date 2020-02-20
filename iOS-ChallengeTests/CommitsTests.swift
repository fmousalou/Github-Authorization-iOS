//
//  CommitsTests.swift
//  iOS-ChallengeTests
//
//  Created by erfan on 12/1/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Foundation
import XCTest

@testable import iOS_Challenge

class CommitsTests: XCTestCase {
    
    var sut: CommitsViewModel!
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testOwnerValue() {
        let owner = "owner"
        sut = CommitsViewModel(owner: owner, repo: "repo")
        XCTAssert(sut.owner == owner, "Incorrect owner value")
    }
    func testRepoValue() {
        let repo = "repo"
        sut = CommitsViewModel(owner: "owner", repo: repo)
        XCTAssert(sut.repo == repo, "Incorrect repo value")
    }
    func testCommitsURL() {
        let owner = "owner"
        let repo = "repo"
        XCTAssert(URLs.commitsURL(forOwner: owner, forRepo: repo) == "https://api.github.com/repos/owner/repo/commits", "Incorrect url")
    }

}
