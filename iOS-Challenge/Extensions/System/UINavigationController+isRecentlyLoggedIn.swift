//
//  UINavigationController+isRecentlyLoggedIn.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/5/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

extension UINavigationController {
    var loggedInRecently: Bool {
        if (self.viewControllers.last as? LoginController) != nil {
            return true
        }else {
            return false
        }
    }
}
