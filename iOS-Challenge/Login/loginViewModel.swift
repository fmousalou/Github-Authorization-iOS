//
//  loginViewModel.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 1/28/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
import Alamofire

class LoginViewModel {
    
    
    func Login(){
        let Loginurl = Route.LoginServices(.oathLogin).url
        guard let urlRequest = try? URLRequest(url: Loginurl, method: .get) else {
            return
        }
        let parameters = ["client_id": Config.clientId,
                          "redirect_uri": Config.loginDeepLink,
                          "scope": "repo",
                          "state": 0] as [String:Any]
        
        guard let requestURL = (try? URLEncoding.default.encode(urlRequest, with:parameters))?.url else {
            return
        }
        

        UIApplication.shared.open(requestURL,
                                  options: [:]) { (result) in
                                    print(result)
        }
        
    }
    
    
}
