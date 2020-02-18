//
//  UIViewControllerExtension.swift
//  iOS-Challenge
//
//  Created by Erfan Andesta on 2/18/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(withTitle title: String?, withMessage message: String?,
                   _ primaryButtonTitle: String? = "OK", _ secondaryButtonTitle: String? = nil,
                   _ primaryButtonCompletionHandler: ((UIAlertAction) -> Void)? = nil,
                   _ secondaryButtonCompletionHandler: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let primaryAction = UIAlertAction(title: primaryButtonTitle, style: .default, handler: primaryButtonCompletionHandler)
        let secondaryAction = UIAlertAction(title: primaryButtonTitle, style: .default, handler: secondaryButtonCompletionHandler)
        
        alertController.addAction(primaryAction)
        if let _ = secondaryButtonTitle {
            alertController.addAction(secondaryAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    func handleError(error: Error) {
        showAlert(withTitle: nil, withMessage: error.localizedDescription)
    }
}
