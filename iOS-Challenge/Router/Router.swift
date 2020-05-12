//
//  Router.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 1/28/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
import UIKit
struct Router {
    static let goTo = Router()
    
    private init(){}
}


extension Router {
    func Home(target : UIViewController) {
        DispatchQueue.main.async {
            let story = UIStoryboard(name: "Search", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "Search")
            vc.modalPresentationStyle = .overFullScreen
            target.present(vc, animated: true)
        }
    }    
}
extension Router {
    func mainTabbar() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "MainTabbar", bundle: nil)
            guard let vc = storyboard.instantiateInitialViewController() else {return}
            UIApplication.shared.keyWindow?.rootViewController = vc
        }
    }
}

extension Router {
    func SplashView() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "MainTabbar", bundle: nil)
            guard let vc = storyboard.instantiateInitialViewController() else {return}
            UIApplication.shared.keyWindow?.rootViewController = vc
        }
    }
}

extension Router {
    func CommitList(target: UITableViewController) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "CommitListVC", bundle: nil)
            guard let vc = storyboard.instantiateInitialViewController() else {return}
            if let navigation = target.navigationController {
                navigation.pushViewController(vc, animated: true)
            }else{
                vc.modalPresentationStyle = .overFullScreen
                target.present(vc, animated: true)
            }
            
        }
    }
}

extension Router {
    func Login() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            guard let vc = storyboard.instantiateInitialViewController() else {return}
            UIApplication.shared.keyWindow?.rootViewController = vc
        }
    }
}

