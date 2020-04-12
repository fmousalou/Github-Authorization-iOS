//
//  ViewController.swift
//  iOS-Challenge
//
//  Created by Farshad Mousalou on 1/28/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import SafariServices


class ViewController: UIViewController {

    @IBOutlet weak var accessTokenLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginDidPress(_ sender: Any?) {
        let oauthAuthorizeNetwork = OAuthAuthorizeNetwork(scope: "repo user", state: 0)
        if let url = oauthAuthorizeNetwork.getURL() {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    func getAuthentication(with code: String?) {
        
        guard let code = code else { return }
        
        OAuthAccessTokenNetwork(code: code, state: 0)
            .execute(onSuccess: { (response) in
                print(response)
            }, onError: { (error) in
                print("Error in OAuthAccessTokenNetwork")
            }) { (connectionError) in
                print("ConnectionError in OAuthAccessTokenNetwork")
        }
        
        
    }

}



