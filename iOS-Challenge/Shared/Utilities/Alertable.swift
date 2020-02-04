//
//  Alertable.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

/// shows alert
public protocol Alertable {}

public extension Alertable where Self: UIViewController {
    
    /// Show alert controller
    /// - Parameter title: title of alert
    /// - Parameter message: message of allert
    /// - Parameter preferredStyle: style
    /// - Parameter completion: callback when action is done
    func showAlert(title: String = "", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
}
