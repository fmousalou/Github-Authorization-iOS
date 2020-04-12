//
//  RepositoriesSearchVC.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class RepositoriesSearchVC: BaseVC {
    
    private var viewModel : RepositoriesSearchVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RepositoriesSearchVM(self)
    }
    
}
