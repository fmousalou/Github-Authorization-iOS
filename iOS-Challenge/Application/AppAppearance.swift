//
//  AppAppearance.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/6/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

/// Set initial appearance for all the app
final class AppAppearance: NSObject
{
    static func setupAppearance() {
        UINavigationBar.appearance().barTintColor = .systemBackground
        UINavigationBar.appearance().tintColor = .systemPink
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPink]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPink]

    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}


