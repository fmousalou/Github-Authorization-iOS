//
//  ProfileVC.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class ProfileVC: BaseVC {
    
    private var viewModel : ProfileVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProfileVM(self)
    }
    
}
