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
import NVActivityIndicatorView

//let clientId = "your-clientId"
let clientId = "04860a64b85b7438bf91"
let clientSecret = "13342aaf3eb01b5498fc16b1bad90e1ab0e64a28"
let redirect_url = "challenge://app/callback"

class LoginController: UIViewController, Storyboarded, NVActivityIndicatorViewable{
    weak var coordinator: MainCoordinator?
    //MARK: Variable
    lazy var keychain = KeychainAPI()
    
    //MARK: Action
    @IBAction private func loginPressed(_ sender: Any) {
        coordinator?.openGithub()
    }
    
    //MARK: Network
    func getAuthentication(with code: String?) {
        guard let code = code else { return }
        startAnimating(message: "Connecting to the server", type: .lineScalePulseOutRapid)
        let gitService = MoyaProvider<GithubService>()
        gitService.request(.authenticate(code: code)) {
            [weak self]
            (result) in
            guard let sSelf = self else { return}
            
            switch result {
            case .success(let response):
                if let tokenObj = try? response.map(AccessTokenResponse.self),
                    let accessToken = tokenObj.accessToken {
                    sSelf.keychain.store(token: accessToken)
                    sSelf.stopAnimating()
                    sSelf.coordinator?.main()
                }
            case .failure:
                sSelf.stopAnimating()
            }
        }
    }
}
