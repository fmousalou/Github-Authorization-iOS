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
        let bearerTokenRepository: BearerTokenRepository
        let appDIContainer: AppDIContainer
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func makeMainView() -> RepositoriesViewController {
        return RepositoriesViewController.create(with: makeRepositoriesViewModel(), repositoryListFactory: self)
    }
    
    func makeRepositoriesViewModel() -> RepositoriesViewModel {
        return DefaultRepositoriesViewModel(dependency:
            DefaultRepositoriesViewModel.Dependency(
                fetchRepositoriesFromServerUseCase: makeSearchedFetchRepositoriesFromServerUseCase(),
                logoutUserUseCase: DefaultLogoutUserUseCase(
                    dependency: DefaultLogoutUserUseCase.Dependency(
                        bearerTokenRepository: makeBearerTokenRepository()))))
    }
    
    func makeLogoutUserUseCase() -> LogoutUserUseCase {
        return DefaultLogoutUserUseCase(dependency: DefaultLogoutUserUseCase.Dependency(bearerTokenRepository: makeBearerTokenRepository()))
    }
    
    func makeBearerTokenRepository () -> BearerTokenRepository{
        return dependency.bearerTokenRepository
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



extension MainSceneDIContainer: RepositoryListFactory {
    func makeAuthorizationViewController() -> AuthorizationViewController {
        return dependency.appDIContainer.makeAuthorizationSceneDIContainer().makeAuthorizationViewController()
    }
    
    func makeProfileViewController() -> ProfileViewController {
        fatalError()
    }
    
    func makeCommitsViewController(with repo: Repository) -> CommitsViewController {
        CommitsViewController.create(with: DefaultCommitsViewModel(
            dependency:DefaultCommitsViewModel.Dependency(fetchCommitsFromServerUseCase: makeFetchCommitsFromServerUseCase()),
            repository: repo))
    }
    
    func makeFetchCommitsFromServerUseCase () -> FetchCommitsFromServerUseCase{
        DefaultFetchCommitsFromServerUseCase(
            dependency: DefaultFetchCommitsFromServerUseCase.Dependency(
                githubCommitsRepository: makeGithubCommitsRepository()))
    }
    func makeGithubCommitsRepository() -> GithubCommitsRepository {
        return DefaultGithubCommitsRepository(dependency: DefaultGithubCommitsRepository.Dependency(dataTransferService: dependency.apiDataTransferService))
    }
    
}

extension MainSceneDIContainer: AuthorizationRouteFactory {
    
}
