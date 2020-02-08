//
//  FetchRepositoriesFromServerUseCase.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/7/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

protocol FetchRepositoriesFromServerUseCase {
    func execute(fetchRequestParameters: FetchListsRequestParameters, fetchRequestHeaders:FetchListRequestHeaders? ,completion:@escaping(Result<Array<Repository>, Error>) -> Void)
}

final class FetchSearchedRepositoriesFromServerUseCase: FetchRepositoriesFromServerUseCase
{
    struct Dependency {
        let githubRepositoriesRepository:GithubRepositoriesRepository
    }
    let dependency: Dependency
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    func execute(fetchRequestParameters: FetchListsRequestParameters, fetchRequestHeaders: FetchListRequestHeaders? = nil, completion: @escaping (Result<Array<Repository>, Error>) -> Void) {
        dependency.githubRepositoriesRepository.fetchRepositories(
            withSearchTerm: fetchRequestParameters.searchTerm ?? "",
            perPage: fetchRequestParameters.perPage,
            pageNumber: fetchRequestParameters.pageNumber,
            completion: completion)
    }
}

struct FetchListsRequestParameters {
    let perPage: Int
    let pageNumber: Int
    let searchTerm: String?
}

struct FetchListRequestHeaders{
    let token: String
}
