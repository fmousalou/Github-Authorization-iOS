//
//  UseCasesTests.swift
//  iOS-ChallengeTests
//
//  Created by Amir Abbas Kashani on 2/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import XCTest
@testable import iOS_Challenge

class UseCasesTests: XCTestCase {

    var createGitHubAuthorizationLinkUseCase: CreateGitHubAuthorizationLinkUseCase!
    var urlString: String!
    override func setUp() {
        createGitHubAuthorizationLinkUseCase = DefaultCreateGitHubAuthorizationLinkUseCase()
        urlString = createGitHubAuthorizationLinkUseCase.execute(clientId: "some id")
    }

    fileprivate func checkQueryParams(_ url: String?) {
        XCTAssertNotNil(url?.contains("client_id"), "clientId is nil")
        XCTAssertNotNil(url?.contains("redirect_uri"), "redirect_uri is nil")
        XCTAssertNotNil(url?.contains("scope"), "scope is nil")
        XCTAssertNotNil(url?.contains("state"), "state is nil")
    }
    
    func testThatCreateTheCorrectUrl() {
        XCTAssertNotNil(urlString, "Url string is nil")
        checkQueryParams(urlString)
    }
    
    func testThatCreatedLinkIsUrlConvertibale() {
        guard let urlString = self.urlString else {
            XCTAssert(false, "Url is nil")
            return
        }
        let url = URL(string: urlString)
        XCTAssertNotNil(url, "Url is not convertibale")
        checkQueryParams(url?.query)
    }
}
