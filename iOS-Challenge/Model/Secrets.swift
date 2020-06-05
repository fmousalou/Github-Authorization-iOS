//
//  Secrets.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/5/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct Secrets: Codable {
    let clientID: String
    let clientSecret: String
    let redirect_url: String
    init() {
        let path = Bundle.main.path(forResource: "Secrets", ofType: "plist")!
        let url = URL(fileURLWithPath: path)
        
        let decoder = PropertyListDecoder()
        let data = try! Data(contentsOf: url)
        let decoded = try! decoder.decode(Secrets.self, from: data)
        clientID = decoded.clientID
        clientSecret = decoded.clientSecret
        redirect_url = decoded.redirect_url
        // Forced unwrap because I know it's there
    }
}
