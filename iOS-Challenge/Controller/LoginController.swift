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

//let clientId = "your-clientId"
//TODO: Move it in secure place
let clientId = "04860a64b85b7438bf91"
let clientSecret = "13342aaf3eb01b5498fc16b1bad90e1ab0e64a28"
let redirect_url = "challenge://app/callback"

class LoginController: UIViewController, Storyboarded, NVActivityIndicatorViewable{
    
    //MARK: Variables
    lazy var keychain = KeychainAPI()
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
        let gitService = MoyaProvider<GithubService>()
        gitService.request(.authenticate(code: code)) {
            [weak self]
            (result) in
            guard let sSelf = self else { return}
            switch result {
            case .success(let response):
                if let tokenObj = try? response.map(AccessTokenResponse.self),
                    let accessToken = tokenObj.accessToken {
                    sSelf.keychain.token = accessToken
                    sSelf.coordinator?.search()
                }
            case .failure:
                Toast.shared.showServerConnectionError()
            }
            sSelf.stopAnimating()
        }
    }
}
