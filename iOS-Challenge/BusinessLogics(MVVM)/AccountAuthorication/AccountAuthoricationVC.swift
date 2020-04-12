//
//  AccountAuthoricationVC.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class AccountAuthoricationVC: BaseVC {
    
    enum RoutePages {
        case reposSearch
    }
    
    private var viewModel : AccountAuthoricationVM!
    private var code: String?
    
    @IBOutlet weak var accessTokenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AccountAuthoricationVM(self)
        getAuthentication()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setData(code: String?) {
        self.code = code
    }

    @IBAction func loginDidPress(_ sender: Any?) {
        if let url = viewModel.getAuthenticationURL() {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    func getAuthentication() {
        guard let code = code else { return }
        viewModel.getToken(code: code)
    }
    
    func route(_ page: RoutePages) {
        var vc: BaseVC!
        
        switch page {
        case .reposSearch:
            vc = SBConstants.home.instantiateViewController(withIdentifier: "RepositoriesSearchVCID") as! RepositoriesSearchVC
        }
        
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
    
}
