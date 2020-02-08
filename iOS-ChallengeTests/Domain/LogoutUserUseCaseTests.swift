//
//  LogoutUserUseCase.swift
//  iOS-ChallengeTests
//
//  Created by Amir Abbas Kashani on 2/8/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import XCTest
@testable import iOS_Challenge

class LogoutUserUseCaseAndBearerTokenTests: XCTestCase {
    var logoutUserUseCase: LogoutUserUseCase!
    var bearerTokenRepository: BearerTokenRepository!
    override func setUp() {
        bearerTokenRepository = MockBearerTokenRepository()
        logoutUserUseCase = DefaultLogoutUserUseCase(dependency: DefaultLogoutUserUseCase.Dependency(bearerTokenRepository: bearerTokenRepository))
        bearerTokenRepository.save(token: "some token", completion: nil)
    }
    
    func testSaveAndFetch() {
        let token = "saved token"
        bearerTokenRepository.save(token: token, completion: nil)
        bearerTokenRepository.fetch { (result) in
            switch result {
            case .success(let newToken): XCTAssertEqual(token, newToken)
            case .failure(let error): XCTAssert(true, error.localizedDescription)
            }
        }
    }

    func testLogoutAndDelete() {
        logoutUserUseCase.execute { (result) in
            switch result{
            case .success(_): break
            case .failure(let error): XCTAssert(true, error.localizedDescription)
            }
        }
    }

}

class NotFoundError: Error{}

class MockBearerTokenRepository: BearerTokenRepository{
    var token: String? = nil
    func save(token: String, completion: ((Result<Bool, Error>) -> Void)?) {
        self.token = token
        completion?(.success(true))
    }
    
    func fetch(completion: @escaping (Result<String, Error>) -> Void) {
        if let t = token {
            completion(.success(t))
            return
        }
        completion(.failure(NotFoundError()))
        
    }
    
    func delete(completion: ((Result<Bool, Error>) -> Void)?) {
        token = nil
        completion?(.success(true))
    }
    
    
}
