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
    struct Dependency {
        let apiDataTransferService: DataTransferService
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func makeMainView() -> UIViewController {
        return RepositoriesViewController.create(with: makeRepositoriesViewModel())
    }
    
    func makeRepositoriesViewModel() -> RepositoriesViewModel {
        return DefaultRepositoriesViewModel(dependency:
            DefaultRepositoriesViewModel.Dependency(
                fetchRepositoriesFromServerUseCase: makeSearchedFetchRepositoriesFromServerUseCase()))
    }
    
    func makeSearchedFetchRepositoriesFromServerUseCase() -> FetchRepositoriesFromServerUseCase {
        return FetchSearchedRepositoriesFromServerUseCase(
            dependency: FetchSearchedRepositoriesFromServerUseCase.Dependency(
                githubRepositoriesRepository: makeGithubRepositoriesRepository()))
    }
    
    func makeGithubRepositoriesRepository() -> GithubRepositoriesRepository{
        return DefaultGithubRepositoriesRepository(dependency: DefaultGithubRepositoriesRepository.Dependency(dataTransferService: dependency.apiDataTransferService))
    }
}
