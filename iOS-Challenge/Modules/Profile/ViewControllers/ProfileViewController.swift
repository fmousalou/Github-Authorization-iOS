//
//  ProfileViewController.swift
//  iOS-Challenge
//
//  Created by Erfan Andesta on 2/19/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK: - Outlets -
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    //MARK: - Actions -
    
    //MARK: - Vars -
    private var viewModel = ProfileViewModel()
    
    //MARK: - View's LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfile()
    }
    
    //MARK: - Functions -
    fileprivate func getProfile() {
        viewModel.getProfile { [weak self] (result) in
            switch result {
            case .success(_): break
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
        viewModel.profile.bind() { [weak self] profile in
            self?.nameLabel.text = profile?.name ?? "-"
            self?.emailLabel.text = profile?.email ?? "-"
            self?.blogLabel.text = profile?.blog ?? "-"
            self?.bioLabel.text = profile?.bio ?? "-"
        }
    }

}
