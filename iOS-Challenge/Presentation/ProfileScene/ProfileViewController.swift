//
//  ProfileViewController.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/7/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController, StoryboardInstantiable
{
    var viewModel: ProfileViewModel!
}

extension ProfileViewController
{
    static func create(with viewModel: ProfileViewModel) -> ProfileViewController {
        let viewController = ProfileViewController.instantiateViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
