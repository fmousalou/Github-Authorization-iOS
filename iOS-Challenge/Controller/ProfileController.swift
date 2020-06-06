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

class ProfileController: UIViewController, NVActivityIndicatorViewable {
    
    //MARK: Variables
    private var user: User? {
        get {
            return KeychainAPI.shared.user
        }
        set {
            KeychainAPI.shared.user = newValue
        }
    }
    
    //MARK: LifeCycle
    override func loadView() {
        if user != nil {
            self.view = ProfileView(user: user!)
        }else {
            self.view = ProfileView(user: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        getUserInfo()
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
//        (view as! ProfileView).nameLabel.text = "Editmode"
    }
    
    deinit {
        print("There isn't retain cycle in \(#file)")
    }
    
    //MARK: Functions
    private func getUserInfo() {
        if user == nil,
            let token = KeychainAPI.shared.token { // It's first time
            
            let authPlugin = AccessTokenPlugin { _ in token }
            let gitService = githubService(plugins: [authPlugin])
            startAnimating(message: "Connecting to the server")
            
            gitService.request(.userInfo) {
                [weak self]
                (result) in
                guard let sSelf = self else { return}
                switch result {
                case .success(let response):
                    if let user = try? response.map(User.self){
                        sSelf.user = user
                        sSelf.view = ProfileView(user: user)
                    }
                case .failure:
                    Toast.shared.showServerConnectionError()
                }
                sSelf.stopAnimating()
            }
        }
    }
    
    private func updateUser() {
        let authPlugin = AccessTokenPlugin { _ in KeychainAPI.shared.token! }
        let gitService = githubService(plugins: [authPlugin])
        startAnimating(message: "Connecting to the server")
        gitService.request(.update(user: User())) {
            [weak self]
            (result) in
            guard let sSelf = self else { return}
            switch result {
            case .success(let response):
                if let updatedUser = try? response.map(User.self) {
                    print("User Updated \n \(updatedUser)")
                    KeychainAPI.shared.user = updatedUser
                }else {
                    Toast.shared.showIn(body: "Can't update your profile!")
                }
            //                sSelf.processUpdated(user: json)
            case .failure:
                Toast.shared.showServerConnectionError()
            }
            sSelf.stopAnimating()
        }
    }
}
