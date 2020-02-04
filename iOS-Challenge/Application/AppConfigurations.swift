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
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiClientId") as? String else {
            fatalError("ApiClientId must not be empty in plist")
        }
        return apiKey
    }()
    
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
    
    lazy var apiClientSecret: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiClientSecret") as? String else {
            fatalError("ApiClientSecret must not be empty in plist")
        }
        return apiBaseURL
    }()

}
