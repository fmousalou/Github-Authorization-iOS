//
//  ViewController.swift
//  iOS-Challenge
//
//  Created by Farshad Mousalou on 1/28/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let vm = LoginViewModel()
    
    @IBOutlet weak var accessTokenLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginDidPress(_ sender: Any?) {
        vm.Login()
    }
    
    
}

