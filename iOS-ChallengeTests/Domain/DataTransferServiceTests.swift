//
//  DataTransferServiceTests.swift
//  iOS-ChallengeTests
//
//  Created by Amir Abbas Kashani on 2/8/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import XCTest
@testable import iOS_Challenge
@testable import Alamofire

class DataTransferServiceTests: XCTestCase {
    var service: DefaultDataTransferService!
    var requestable: MockRequestable!
    override func setUp() {
        service =  DefaultDataTransferService()
        requestable = MockRequestable()
    }
    
    func testDefaultWorking() {
        let expect = expectation(description: "DataTransferService Test")
        service.request(with: requestable) { (result: Swift.Result<[Commit], Error>) in
            switch result{
            case .success(_): break
            case .failure(let error): XCTAssert(true, error.localizedDescription)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }
}

class MockRequestable: Requestable{
    var baseURLString: String = "https://api.github.com/repos/chvin/react-tetris/commits"
    
    var path: String?
    
    var method: HTTPMethod = .get
    
    var queryParameters: [String : Any]? = nil
    var headerParamaters: [String : String]? = nil
    
    var bodyParamaters: [String : Any]? = nil
    
    var bodyEncoding: ParameterEncoding = JSONEncoding.prettyPrinted
    
    
}
