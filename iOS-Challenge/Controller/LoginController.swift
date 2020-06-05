//
//  LoginController.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/2/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import Moya
import NVActivityIndicatorView
import Pulsator

class LoginController: UIViewController, Storyboarded, NVActivityIndicatorViewable{
    
    //MARK: Variables
    weak var coordinator: MainCoordinator?
    @IBOutlet weak var loginBtn: UIButton!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Animate login button
        let pulsator = Pulsator()
        pulsator.position = CGPoint(x: loginBtn.layer.bounds.midX, y: loginBtn.layer.bounds.midY)
        pulsator.radius = 240.0
        pulsator.pulseInterval = 1
        loginBtn.layer.addSublayer(pulsator)
        pulsator.start()
    }
    
    //MARK: Action
    @IBAction private func loginPressed(_ sender: Any) {
        // ios 10 and lower
        coordinator?.openGithub()
        // TODO: Add open in app safari for upper iOS
    }
    
    //MARK: Network
    func getAuthentication(with parameters: QueryParameters) {
        if parameters.keys.contains("error") {
            Toast.shared.showServerConnectionError()
            self.stopAnimating()
            return
        }
        
        guard let code = parameters["code"] else { return }
        startAnimating(message: "Connecting to the server")
        let gitService = githubService()
        gitService.request(.authenticate(code: code)) {
            [weak self]
            (result) in
            guard let sSelf = self else { return}
            switch result {
            case .success(let response):
                if let tokenObj = try? response.map(AccessTokenResponse.self),
                    let accessToken = tokenObj.accessToken {
                    KeychainAPI.shared.token = accessToken
                    sSelf.coordinator?.search()
                }else {
                    Toast.shared.showIn(body: "I can't authorize")
                }
            case .failure:
                Toast.shared.showServerConnectionError()
            }
            sSelf.stopAnimating()
        }
    }
}
