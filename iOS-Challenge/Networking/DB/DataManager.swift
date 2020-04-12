//
//  DataManager.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

enum DBConstantKeys: String{
    case token = "Challenge.Token"
    case tokenType = "Challenge.TokenType"
 }

class DataManager{
    
    static let shared = DataManager()
    
    func resetAll() {
        DataManager.shared.setToken(token: "")
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
    func getToken() -> String {
        return SDUserDefault.getStringValue(forKey: DBConstantKeys.token.rawValue) ?? ""
    }
    
    func setToken(token: String) {
        SDUserDefault.setStringValue(value: token, forKey: DBConstantKeys.token.rawValue)
    }
    
    func getTokenType() -> String {
        return SDUserDefault.getStringValue(forKey: DBConstantKeys.tokenType.rawValue) ?? ""
    }
    
    func setTokenType(token: String) {
        SDUserDefault.setStringValue(value: token, forKey: DBConstantKeys.tokenType.rawValue)
    }
    
}


public class SDUserDefault {
    public class func setStringValue(value: String, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    
    public class func getStringValue(forKey: String) -> String? {
        return UserDefaults.standard.object(forKey: forKey) as? String
    }
    
    public class func setIntValue(value: Int, forKey: String) {
        UserDefaults.standard.setValue(value, forKey: forKey)
    }
    
    public class func getIntValue(forKey: String) -> Int? {
        return UserDefaults.standard.object(forKey: forKey) as? Int
    }
    
    public class func setBoolValue(bool: Bool, forKey: String) {
        UserDefaults.standard.set(bool, forKey: forKey)
    }
    
    public class func getBoolValue(forKey: String) -> Bool? {
        return UserDefaults.standard.bool(forKey: forKey)
    }
}
