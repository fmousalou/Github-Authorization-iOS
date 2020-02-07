//
//  MainSceneDIContainer.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/5/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

final class MainSceneDIContainer
{
    func makeMainView() -> UIViewController {
        return RepositoriesViewController.create(with: makeRepositoriesViewModel())
    }
    
    func makeRepositoriesViewModel() -> RepositoriesViewModel {
        return DefaultRepositoriesViewModel()
    }
}
