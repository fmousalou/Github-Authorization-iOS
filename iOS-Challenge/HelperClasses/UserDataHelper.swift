//
//  UserDataHelper.swift
//  iOS-Challenge
//
//  Created by anna on 11/15/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Foundation



class UserDataHelper{
    
    private let sharedPrefrences = SharedPrefrences()
    
    
    /// GET User GitHub Token , If Exists
    func getToken() -> String? {
        if let token = sharedPrefrences.get(key: .gitToken) as? String{
            return token
        }
        return nil
    }
    
    /// SET User GitHub Token
    func setToken(token:String){
        sharedPrefrences.set(key: .gitToken, value: token)
    }
    
    
    
}
