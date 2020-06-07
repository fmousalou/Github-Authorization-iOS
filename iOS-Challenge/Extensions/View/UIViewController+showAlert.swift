//
//  UIViewController+showAlert.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/6/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(options[index])
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
