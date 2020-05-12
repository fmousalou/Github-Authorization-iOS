//
//  SplashVC.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 1/30/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit

class SplashVC: UIViewController {
    let prefrence = FirstRunPrefrences()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.routeUser()
        }
    }
    
    func routeUser(){
        if prefrence.isLogedin() {
            Router.goTo.mainTabbar()
        }else{
            Router.goTo.Login()
        }
    }
    
}
