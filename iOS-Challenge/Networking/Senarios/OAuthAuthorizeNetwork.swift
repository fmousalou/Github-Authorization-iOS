//
//  OAuthAuthorizeNetwork.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

/// - OAuthAuthorizeNetwork
struct OAuthAuthorizeNetwork {
    
    var scope: String = ""
    var state: Int = 0
    
    init(scope: String, state: Int) {
        self.scope = scope
        self.state = state
    }
    
    func getURL() -> URL? {
        guard let url = URL(string:ConstantURLs.core + "login/oauth/authorize?client_id=\(ConstantURLs.clientId)&redirect_uri=\(ConstantURLs.redirect_url)&scope=\(scope)&state=\(state)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            return nil
        }
        return url
        
    }

}
