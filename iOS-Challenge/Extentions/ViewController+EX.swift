//
//  ViewController+EX.swift
//  iOS-Challenge
//
//  Created by anna on 11/15/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showAlert(title:String,message:String,actions:[UIAlertAction]? = nil){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
     
        // Add Actions
        if let actions = actions  {
            for action in actions {
               alert.addAction(action)
            }
        }else{
            let defaultAction = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(defaultAction)
        }
        
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    
}
