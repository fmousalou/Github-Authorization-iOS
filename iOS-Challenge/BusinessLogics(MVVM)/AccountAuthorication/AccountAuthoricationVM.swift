//
//  AccountAuthoricationVM.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

class AccountAuthoricationVM {
    
    weak var vc: AccountAuthoricationVC!
    
    init(_ vc: AccountAuthoricationVC) {
        self.vc = vc
    }
    
    func loadData() {
        
    }
    
    func getAuthenticationURL() -> URL? {
        let oauthAuthorizeNetwork = OAuthAuthorizeNetwork(scope: "repo user", state: 0)
        return oauthAuthorizeNetwork.getURL()
    }
    
    func getToken(code: String) {
        OAuthAccessTokenNetwork(code: code, state: 0)
            .execute(onSuccess: { [weak self] (response) in
                if let token = response.access_token {
                    DataManager.shared.setToken(token: token)
                }
                if let tokenType = response.token_type {
                    DataManager.shared.setTokenType(token: tokenType)
                }
                self?.vc.route(.reposSearch)
            }, onError: { (error) in
                print("Error in OAuthAccessTokenNetwork")
            }) { (connectionError) in
                print("ConnectionError in OAuthAccessTokenNetwork")
        }
    }
    
}
