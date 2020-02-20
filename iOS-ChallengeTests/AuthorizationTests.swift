//
//  AuthorizationTests.swift
//  iOS-ChallengeTests
//
//  Created by Erfan Andesta on 2/18/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import XCTest

@testable import iOS_Challenge

class AuthorizationTests: XCTestCase {
    
    var sut: AuthorizationViewModel!
    
    override func setUp() {
        super.setUp()
        sut = AuthorizationViewModel()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testLogin() {
        sut.login { (result) in
            switch result {
            case .success(let url):
                XCTAssert(url == URL(string: "https://github.com/login/oauth/authorize?client_id=04860a64b85b7438bf91&redirect_uri=challenge%3A//app/callback&scope=repo%20user&state=0")!, "Incorrect url")
            case .failure( _):
                XCTFail()
            }
        }
    }

}
