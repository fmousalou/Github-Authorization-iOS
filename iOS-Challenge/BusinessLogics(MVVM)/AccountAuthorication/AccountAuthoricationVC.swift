//
//  AccountAuthoricationVC.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class AccountAuthoricationVC: BaseVC {
    
    private var viewModel : AccountAuthoricationVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AccountAuthoricationVM(self)
    }
    
}
