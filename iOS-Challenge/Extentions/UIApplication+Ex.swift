//
//  UIApplication+Ex.swift
//  SmartFix
//
//  Created by anna on 2018-09-03.
//  Copyright © 2018 Sepandar Co. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
    
    func logOut(){
        let sharedPrefrences = SharedPrefrences()
        sharedPrefrences.removeAll()
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let logInController = storyboard.instantiateViewController(withIdentifier: "loginID")
         self.setRoot(viewController: logInController)
            
        
    }
    
    func setRoot(viewController:UIViewController) {
        self.windows.first?.rootViewController = viewController
        self.windows.first?.makeKeyAndVisible()
        }
}
