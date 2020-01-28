//
//  ViewController.swift
//  iOS-Challenge
//
//  Created by Farshad Mousalou on 1/28/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import Alamofire
import SafariServices

//let clientId = "your-clientId"
let clientId = "04860a64b85b7438bf91"

class ViewController: UIViewController {

    @IBOutlet weak var accessTokenLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginDidPress(_ sender: Any?) {
                
        guard let url = URL(string:"https://github.com/login/oauth/authorize") else {
            return
        }
        
        guard let urlRequest = try? URLRequest(url: url, method: .get) else {
            return
        }
        
        let parameters = ["client_id": clientId,
                          "redirect_uri": "challenge://app/callback",
                          "scope": "repo",
                          "state": 0] as [String:Any]
        
        guard let requestURL = (try? URLEncoding.default.encode(urlRequest, with:parameters))?.url else {
            return
        }
        

        UIApplication.shared.open(requestURL,
                                  options: [:]) { (result) in
                                    print(result)
        }
        
    }


}

