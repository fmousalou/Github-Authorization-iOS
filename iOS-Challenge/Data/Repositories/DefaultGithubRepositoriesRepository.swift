//
//  DefaultGithubRepositoriesRepository.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/7/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

final class DefaultGithubRepositoriesRepository: GithubRepositoriesRepository
{
    struct Dependency {
        let dataTransferService: DataTransferService
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func fetchRepositories(withSearchTerm term: String, perPage: Int, pageNumber: Int, completion: @escaping (Result<Array<Repository>, Error>) -> Void) {
        let endpoint = APIEndpoints.repositories(with: term, page: pageNumber, perPage: perPage)
        
        dependency.dataTransferService.request(with: endpoint) { (result: Result<RepositorySearchResponseModel, Error>) in
            switch result {
            case .success(let repos):
                DispatchQueue.main.async { completion(Swift.Result.success(repos.items ?? [])) }
            case .failure(let error):
                DispatchQueue.main.async { completion(Swift.Result.failure(error)) }
            }
        }
    }
}
