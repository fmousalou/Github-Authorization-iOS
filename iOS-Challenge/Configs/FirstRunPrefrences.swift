//
//  Authenticate.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 1/28/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
import KeychainSwift

class FirstRunPrefrences {
    let keychain = KeychainSwift()
    func keychainSetup(){
        if isFirstRun(){
            keychain.clear()
            print(keychain.allKeys)
        }
    }
    
    func isLogedin()->Bool{
        if let token = keychain.get("token") {
            Global.token = token
            return true
        }else{
            return false
        }
    }
    
    fileprivate func isFirstRun() -> Bool{
        if UserDefaults.standard.object(forKey: "FirstRun") == nil {
            return false
        }else{
            UserDefaults.standard.setValue("1strun", forKey: "FirstRun")
            UserDefaults.standard.synchronize()
            return true
        }
    }
}
