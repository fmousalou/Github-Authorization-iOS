//
//  KeychainAPI.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import KeychainAccess

class KeychainAPI {

    // MARK:- Private
    private let keychain: Keychain = {
        return Keychain(service: "com.digipay.iOS-Challenge")
    }()
    private let tokenKey = "digipay-token"
    
    func clearKeychain() {
        if let _ = try? self.keychain.contains(tokenKey) {
            try! self.keychain.removeAll()
        }
    }
    
    // MARK:- Functions (Token)
    func getToken() -> String? {
        if let token = try? keychain.get(tokenKey) {
            return token
        }else {
            return nil
        }
    }
    func store(token: String) {
        do {
            try keychain.set(token, key: tokenKey)
        } catch let err {
            print("\(err) in \(#function)")
        }
    }
}
