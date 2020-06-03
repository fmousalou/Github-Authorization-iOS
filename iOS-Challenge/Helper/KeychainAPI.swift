//
//  KeychainAPI.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import KeychainAccess

class KeychainAPI {

    // MARK:- Variables
    // Private
    private let keychain: Keychain = {
        return Keychain(service: "com.digipay.iOS-Challenge")
    }()
    private let tokenKey = "digipay-token"
    
    // Public
    var token: String? {
        get {
            // TODO: Correct it
            return nil
            guard let token =  try? keychain.get(tokenKey)  else{
                return nil
            }
            return token
        }
    }
    
    
    // MARK:- Functions (Token)
    func clearKeychain() {
        if let _ = try? self.keychain.contains(tokenKey) {
            try! self.keychain.removeAll()
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
