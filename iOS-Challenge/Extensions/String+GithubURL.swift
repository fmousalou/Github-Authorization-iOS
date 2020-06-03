//
//  String+GithubURL.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Alamofire


extension String {
    //TODO Make it better
    var githubURL: URL? {
        let parameters = ["client_id": clientId,
        "redirect_uri": redirect_url,
        "scope": "repo user",
        "state": 0] as [String:Any]
        
        if let urlRequest = try? URLRequest(url: self, method: .get),
            let requestURL = (try? URLEncoding.default.encode(urlRequest, with:parameters))?.url {
            return requestURL
        }
        return nil
    }
}
