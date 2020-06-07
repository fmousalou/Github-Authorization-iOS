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
import Reachability

class ProfileController: UIViewController, NVActivityIndicatorViewable {
    // TODO: Make ViewModel
    //MARK:- Variables
    private let reachability: Reachability
    private let profileView = ProfileView()
    private var suspendedRequest = false
    private var user: User? {
        get {
            KeychainAPI.shared.user
        }
        set {
            KeychainAPI.shared.user = newValue
        }
    }
    
    //MARK:- Init
    init() {
        self.reachability = try! Reachability()
        super.init(nibName: nil, bundle: nil)
        initReachability()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("There isn't retain cycle in \(#file)")
    }
    private func initReachability() {
        reachability.whenReachable = {
            [weak self] _ in
            guard let sSelf = self else { return}
            // If there is a suspended request
            guard sSelf.suspendedRequest == true else { return}
            // Send request again
            sSelf.sendUpdateRequest()
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Error in \(#function)")
        }
    }
    
    //MARK:- LifeCycle
    override func loadView() {
        self.view = self.profileView
        // In order to assign variables to views
        self.profileView.user = user
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        navigationItem.rightBarButtonItem = editButtonItem
        fetchUserInfo()
    }
    
    //MARK:- Functions
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        profileView.editable = editing
        if !editing /*check if values changed*/ {
            // Ask if he/she wants to update profile
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
                sSelf.sendUpdateRequest()
            case "No":
                Toast.shared.showIn(body: "Updating canceled!")
            default:
                break
            }
        }
    }
    
    private func getUserInfoFromUI() -> User {
        // Get textfields
        let textFieldsStack = profileView.textFields
        // Read data
        let name = textFieldsStack[0].text
        let company = textFieldsStack[1].text
        let location = textFieldsStack[2].text
        let bio = profileView.bioText
        
        // Make model
        let user = User(name: name,
                        company: company,
                        location: location,
                        email: nil,
                        bio: bio,
                        public_repos: nil, followers: nil, following: nil, avatar_url: nil)
        return user
    }
    
    private func sendUpdateRequest() {
        guard reachability.isConnected else {
            Toast.shared.showInternetConnectionError()
            self.suspendedRequest = true
            return
        }
        let newUser = getUserInfoFromUI()
        self.update(new: newUser)
    }
    
    //MARK: Network
    private func fetchUserInfo() {
        if user == nil, // It's first time
            let token = KeychainAPI.shared.token { // Get Token
            
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
                        // Save in keychain
                        sSelf.user = user
                        // Update UI
                        sSelf.profileView.user = user
                    }else {
                        Toast.shared.showIn(body: "Can't show your profile!")
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
                if let updatedUser = try? response.map(User.self) {
                    sSelf.suspendedRequest = false
                    // Save in Keychain
                    sSelf.user = updatedUser
                    // Show proper Message
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
