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
    // TODO: Move logics to ViewModel
    // TODO: Park Request
    //MARK: Variables
    private var user: User? {
        get {
            return KeychainAPI.shared.user
        }
        set {
            KeychainAPI.shared.user = newValue
        }
    }
    private var profileView: ProfileView?
    
    //MARK: LifeCycle
    override func loadView() {
        if user != nil {
            profileView = ProfileView(user: user!)
        }else {
            profileView = ProfileView(user: nil)
        }
        self.view = self.profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        fetchUserInfo()
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    deinit {
        print("There isn't retain cycle in \(#file)")
    }
    
    //MARK: Functions
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        guard let profileView = profileView else { return}
        let tfStack = profileView.textFieldsStack
        tfStack.arrangedSubviews.forEach {
            if let tf = $0 as? UITextField {
                tf.isUserInteractionEnabled = editing
            }
        }
        (tfStack.arrangedSubviews.first as? UITextField)?.becomeFirstResponder()
        profileView.bioTV.isEditable = editing
        
        if editing == false /*And then values changed*/ {
            // Ask if he/she want to update profile or no
            showAlert()
        }
    }
    
    //MARK: Preapare network request
    private func showAlert() {
        presentAlertWithTitle(title: "Do you want update your account?",
                              message: "",
                              options: "No" , "Sure!")
        {
            [weak self]
            (option) in
            guard let sSelf = self else { return}
            switch(option) {
            case "Sure!":
                if let newUser = sSelf.getUserInfoFromUI() {
                    sSelf.update(new: newUser)
                }else {
                    Toast.shared.showIn(body: "Fill all fields please!")
                }
            case "No":
                Toast.shared.showIn(body: "Updating canceled!")
            default:
                break
            }
        }
    }
    
    private func getUserInfoFromUI() -> User? {
        // Get textfields
        guard let textFieldsStack = profileView?.textFieldsStack.arrangedSubviews else { return nil}
        // Read data
        guard let name = (textFieldsStack[0] as? UITextField)?.text,
            let company = (textFieldsStack[1] as? UITextField)?.text,
            let location = (textFieldsStack[2] as? UITextField)?.text,
            let bio = profileView?.bioTV.text
            else { return nil}
        // Make model
        let user = User(name: name,
                        company: company,
                        location: location,
                        email: nil,
                        bio: bio,
                        public_repos: nil, followers: nil, following: nil, avatar_url: nil)
        return user
    }
    
    //MARK: Network
    private func fetchUserInfo() {
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
    
    private func update(new: User) {
        let authPlugin = AccessTokenPlugin { _ in KeychainAPI.shared.token! }
        let gitService = githubService(plugins: [authPlugin])
        startAnimating(message: "Connecting to the server")
        gitService.request(.update(user: new)) {
            [weak self]
            (result) in
            guard let sSelf = self else { return}
            switch result {
            case .success(let response):
                let js = try! response.mapJSON()
                print(js)
                if let updatedUser = try? response.map(User.self) {
                    print("User Updated \n \(updatedUser)")
                    sSelf.user = updatedUser
                    Toast.shared.showIn(body: "Successfully updated profile!",
                                        icon: "😍", theme: .success)
                }else {
                    Toast.shared.showIn(body: "Can't update your profile!")
                }
            case .failure:
                Toast.shared.showServerConnectionError()
            }
            sSelf.stopAnimating()
        }
    }
}



