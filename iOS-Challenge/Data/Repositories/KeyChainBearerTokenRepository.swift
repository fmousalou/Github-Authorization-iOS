//
//  KeyChainBearerTokenRepository.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/5/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import KeychainAccess

class KeyChainBearerTokenRepository: BearerTokenRepository
{
    struct NotFoundInKeychainError:Error {
        
    }
    struct Dependency {
        let serviceKey: String
        let tokenKey: String
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }

    
    func save(token: String, completion: ((Result<Bool, Error>) -> Void)?) {
        let keychain = Keychain(service: dependency.serviceKey)
        keychain[dependency.tokenKey] = token
        completion?(Result.success(true))
    }
    
    func fetch(completion: @escaping (Result<String, Error>) -> Void) {
        let keychain = Keychain(service: dependency.serviceKey)
        guard let token = keychain[dependency.tokenKey] else {
            completion(Result.failure(NotFoundInKeychainError()))
            return
        }
        completion(Result.success(token))
    }
}
