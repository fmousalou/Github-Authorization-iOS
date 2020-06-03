//
//  LoginController.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/2/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import Alamofire
import Moya

//let clientId = "your-clientId"
let clientId = "04860a64b85b7438bf91"
let clientSecret = "13342aaf3eb01b5498fc16b1bad90e1ab0e64a28"
let redirect_url = "challenge://app/callback"

class LoginController: UIViewController, Storyboarded {
    
    var keychain = KeychainAPI()
    
    @IBAction func loginPressed(_ sender: Any) {
        openGithub()
    }
    
    private func openGithub() {
        guard let url = URL(string:"https://github.com/login/oauth/authorize") else {
            return
        }
        
        guard let urlRequest = try? URLRequest(url: url, method: .get) else {
            return
        }
        
        let parameters = ["client_id": clientId,
                          "redirect_uri": redirect_url,
                          "scope": "repo user",
                          "state": 0] as [String:Any]
        
        guard let requestURL = (try? URLEncoding.default.encode(urlRequest, with:parameters))?.url else {
            return
        }
        
        UIApplication.shared.open(requestURL,
                                  options: [:])
    }
    
    func getAuthentication(with code: String?) {
        
        guard let code = code else { return }
        
        
        let gitService = MoyaProvider<GithubService>()
        gitService.authenticate(code)
        
//        guard let url = URL(string:"https://github.com/login/oauth/access_token") else {
//            return
//        }
//
//        let parameters = ["client_id": clientId,
//                          "redirect_uri": redirect_url,
//                          "client_secret": clientSecret,
//                          "code": code,
//                          "state": 0] as [String:Any]
//
//        AF.request(url, method: .post,
//                          parameters: parameters, encoding: JSONEncoding.prettyPrinted,
//                          headers: ["Accept":"application/json"])
//            .validate()
//            .responseDecodable {[weak self] (response : DataResponse<AccessTokenResponse , AFError>) in
//                switch response.result {
//                case .success(let accessToken):
//                    print("it's access token \(accessToken)")
//                    //TODO: Save token in keychain
//                case .failure(let error):
//                    print(error)
//                }
//        }
    }
}
