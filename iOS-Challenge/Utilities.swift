//
//  Utilities.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 1/28/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    typealias completion = (() -> Void)
    func showAlert(message:String , title:String , buttonTitle:String , completion: completion? = nil){
       let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    
//            let titleFont = [NSAttributedString.Key.font: Global.Font.setBold(size: 15)]
//            let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
            alertController.title = title
            alertController.message = message
        
    
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
                if let _ = completion {
                    completion!()
                }else{
                    alertController.dismiss(animated: true, completion: nil)
                }
            })
            alertController.addAction(action)
    
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
//    
//            alertController.view.tintColor = Global.Color.header
    }
}
