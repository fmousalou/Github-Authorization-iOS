//
//  RepositoryCommitsVC.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class RepositoryCommitsVC: BaseVC {
    
    private var viewModel : RepositoryCommitsVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RepositoryCommitsVM(self)
    }
    
}
