//
//  AppConfigurations.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

final class AppConfigurations
{
    lazy var apiClientId: String = {
        guard let apiClientId = Bundle.main.object(forInfoDictionaryKey: "ApiClientId") as? String else {
            fatalError("ApiClientId must not be empty in plist")
        }
        return apiClientId
    }()
    
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
    
    lazy var apiClientSecret: String = {
        guard let apiClientSecret = Bundle.main.object(forInfoDictionaryKey: "ApiClientSecret") as? String else {
            fatalError("ApiClientSecret must not be empty in plist")
        }
        return apiClientSecret
    }()
    
    lazy var keychainServiceKey: String = {
        guard let keychainServiceKey = Bundle.main.object(forInfoDictionaryKey: "KeychainServiceKey") as? String else {
            fatalError("KeychainServiceKey must not be empty in plist")
        }
        return keychainServiceKey
    }()
    
    lazy var state = "0"
    #warning("Must be completed")
    lazy var redirectUrl = ""
    lazy var keychainKey = "tokenKey"
}
