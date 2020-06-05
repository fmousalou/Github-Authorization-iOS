//
//  String+GithubURL.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Moya

extension String {
    //TODO: Make it better
    var githubURL: URL? {
        let secrets = Secrets()
        let parameters = ["client_id": secrets.clientID,
        "redirect_uri": secrets.redirect_url,
        "scope": "repo user",
        "state": 0] as [String:Any]
        
        if let urlRequest = try? URLRequest(url: self, method: .get),
            let requestURL = (try? URLEncoding.default.encode(urlRequest, with:parameters))?.url {
            return requestURL
        }
        return nil
    }
}
