//
//  UserDefaultsService.swift
//  iOS-Challenge
//
//  Created by Erfan Andesta on 2/19/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

class UserDefaultsService {
    
    private init() {}
    static var shared = UserDefaultsService()
    private let tokenKey = "tokenKey"
    private var userDefaults = UserDefaults.standard
    
    func setToken(_ token: String?) {
        userDefaults.set(token, forKey: tokenKey)
    }
    func getToken() -> String? {
        return userDefaults.string(forKey: tokenKey)
    }
}
