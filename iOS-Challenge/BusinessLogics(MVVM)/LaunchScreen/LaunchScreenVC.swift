//
//  LunchScreenVC.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class LaunchScreenVC: BaseVC {
    
    enum RoutePages {
        case reposSearch
        case accountAuthorication
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            let token = DataManager.shared.getToken()
            token.isEmpty ? self?.route(.accountAuthorication) : self?.route(.reposSearch)
        }
    }
    
    func route(_ page: RoutePages) {
        var vc: BaseVC!
        
        switch page {
        case .reposSearch:
            vc = SBConstants.home.instantiateViewController(withIdentifier: "RepositoriesSearchVCID") as! RepositoriesSearchVC
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true, completion: nil)
        case .accountAuthorication:
            vc = SBConstants.home.instantiateViewController(withIdentifier: "AccountAuthoricationVCID") as! AccountAuthoricationVC
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        
    }
    
}
