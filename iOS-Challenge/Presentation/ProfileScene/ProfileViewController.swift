//
//  ProfileViewController.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/7/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import Kingfisher

final class ProfileViewController: UIViewController, StoryboardInstantiable, Alertable
{
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    var viewModel: ProfileViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.title
        bind(to: viewModel)
    }
    
    func bind(to viewModel: ProfileViewModel) {
        viewModel.error.observe(on: self) { [weak self] error in
            guard error.isEmpty == false else { return }
            self?.showAlert(message: error)
        }
        viewModel.user.observe(on: self) { [weak self] (user) in
            guard let _ = user else { return }
            self?.updateUI()
        }
    }
    
    func updateUI() {
        if let url = URL(string: viewModel.avatarURL) { avatarImageView.kf.setImage(with: url) }
        nameLabel.text = viewModel.name
        loginLabel.text = viewModel.login
        companyLabel.text = viewModel.company
    }
}

extension ProfileViewController
{
    static func create(with viewModel: ProfileViewModel) -> ProfileViewController {
        let viewController = ProfileViewController.instantiateViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
