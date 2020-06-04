//
//  UserController.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

@IBDesignable
class UserController: UIViewController {

    override func loadView() {
        let user = User(name: "imamad",
             company: "kabok",
             location: "iran",
             email: "aa.cc.cc",
             bio: "is it",
             public_repos: nil,
             followers: nil,
             following: nil,
             avatar_url: nil)
        self.view = UserView(user: user)
        print("instan")
    }
    
//    let token = keychain.token!
//    let authPlugin = AccessTokenPlugin { _ in token }
//    let gitService = MoyaProvider<GithubService>(plugins: [authPlugin])
//    startAnimating(message: "Connecting to the server")
//    
//    gitService.request(.userInfo) {
//        [weak self]
//        (result) in
//        guard let sSelf = self else { return}
//        switch result {
//        case .success(let response):
//            if let user = try? response.map(User.self){
//                print(user)
//            }
//        case .failure:
//            Toast.shared.showConnectionError()
//        }
//        sSelf.stopAnimating()
//    }
    
    
    private func getUser() {
        // if in keychain return
        
        // if not request
    }

}
