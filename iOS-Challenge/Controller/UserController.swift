//
//  UserController.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import KeychainAccess
import Moya
import NVActivityIndicatorView

class UserController: UIViewController, NVActivityIndicatorViewable {
    
    //MARK:- Dependency
    private let keychain: KeychainAPI
    
    //MARK:- Init
    init(keychain: KeychainAPI) {
        self.keychain = keychain
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- LifeCycle
    override func loadView() {
        self.view = UserView(user: keychain.user)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Profile"
        getUserInfo()
    }
    
    //MARK:- Functions
    private func getUserInfo() {
        if keychain.user == nil, let token = keychain.token { // It's first time
            
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
                        sSelf.keychain.user = user
                        sSelf.view = UserView(user: user)
                    }
                case .failure:
                    Toast.shared.showConnectionError()
                }
                sSelf.stopAnimating()
            }
        }
    }
}
