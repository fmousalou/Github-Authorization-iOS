//
//  UserController.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import Moya
import NVActivityIndicatorView

class UserController: UIViewController, NVActivityIndicatorViewable {
    
    private var user: User? {
        get {
            return KeychainAPI.shared.user
        }
        set {
            KeychainAPI.shared.user = newValue
        }
    }
    
    //MARK:- LifeCycle
    override func loadView() {
        if user != nil {
            self.view = UserView(user: user)
        }else {
            self.view = UserView(user: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        getUserInfo()
    }
    
    //MARK:- Functions
    private func getUserInfo() {
        if user == nil, let token = KeychainAPI.shared.token { // It's first time
            let authPlugin = AccessTokenPlugin { _ in token }
            let gitService = MoyaProvider<GithubService>(plugins: [authPlugin])
            startAnimating(message: "Connecting to the server")
            
            gitService.request(.userInfo) {
                [weak self]
                (result) in
                guard let sSelf = self else { return}
                switch result {
                case .success(let response):
                    if let user = try? response.map(User.self){
                        print(user)
                        sSelf.user = user
                        sSelf.view = UserView(user: user)
                    }
                case .failure:
                    Toast.shared.showServerConnectionError()
                }
                sSelf.stopAnimating()
            }
        }
    }
}
