//
//  RepositoriesViewModel.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/5/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
protocol RepositoriesViewModelInput {}
protocol RepositoriesViewModelOutput {
    var title: String { get }
}
protocol RepositoriesViewModel: RepositoriesViewModelInput, RepositoriesViewModelOutput {}


final class DefaultRepositoriesViewModel: RepositoriesViewModel
{
    var title: String = "Repositories"
}
