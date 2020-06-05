//
//  String+commitsURLPath.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

extension String {
    var commitsURLPath: String? {
        let pureAdrs = self.replacingOccurrences(of: "{/sha}", with: "")
        let purePath = pureAdrs.replacingOccurrences(of: "https://api.github.com", with: "")
        return purePath
    }
}
