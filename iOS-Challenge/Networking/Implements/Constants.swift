//
//  Constants.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct ConstantURLs {
    
    #if DEBUG
        // Develop State
        static let core = "https://github.com/"
        static let clientId = "fbddf1ffb4bc9d2a8124"
        static let clientSecret = "367102c0b6c47f8a3fc80217f43b9edd7a2c4b71"
        static let redirect_url = "challenge://app/callback"
        static let baseImage = ""
    #else
        // Production State
        static let core = "https://github.com/"
        static let clientId = "fbddf1ffb4bc9d2a8124"
        static let clientSecret = "367102c0b6c47f8a3fc80217f43b9edd7a2c4b71"
        static let redirect_url = "challenge://app/callback"
        static let baseImage = ""
    #endif
    
}


struct Pagination {
    
    #if DEBUG
        // Develop State
        static let pageSize = 20
    #else
        // Production State
        static let pageSize = 20
    #endif
    
}
