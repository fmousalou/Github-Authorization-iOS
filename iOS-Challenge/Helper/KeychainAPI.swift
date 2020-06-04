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
    private let userKey = "digipay-userObj"
    
    // Public
    var token: String? {
        get {
            guard let token =  try? keychain.get(tokenKey)  else{
                return nil
            }
            return token
        }
        
        set {
            do {
                if newValue == nil { return}
                try keychain.set(newValue!, key: tokenKey)
            } catch let err {
                print("\(err) in \(#function)")
            }
        }
    }
    
     // Public
        var user: User? {
            get {
                let decoder = JSONDecoder()
                if let userData = try? keychain.getData(userKey),
                    let user = try? decoder.decode(User.self, from: userData){
                    return user
                }
                return nil
            }
            
            set {
                do {
                    let encoder = JSONEncoder()
                    let user = try? encoder.encode(newValue)
                    if user == nil { return}
                    try keychain.set(user!, key: userKey)
                } catch let err {
                    print("\(err) in \(#function)")
                }
            }
        }
    
    
    // MARK:- Functions (Token)
    func clearKeychain() {
        if let _ = try? self.keychain.contains(tokenKey) {
            try! self.keychain.removeAll()
        }
    }
}
