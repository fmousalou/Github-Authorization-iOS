//
//  FetchRepositoriesFromServerUseCase.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/7/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

protocol FetchRepositoriesFromServerUseCase {
    func execute(fetchRequestParameters: FetchListsRequestParameters, fetchRequestHeaders:FetchListRequestHeaders ,completion:@escaping(Result<Array<Repository>, Error>) -> Void)
}


final class FetchUserRepositoriesFromServerUseCase: FetchRepositoriesFromServerUseCase
{
    struct Dependency {
        let githubRepositoriesRepository:GithubRepositoriesRepository
        let parameters: FetchListsRequestParameters
        let headers: FetchListRequestHeaders
    }
    let dependency: Dependency
    
    init(dependency: Dependency, parameters: FetchListsRequestParameters, headers: FetchListRequestHeaders) {
        self.dependency = dependency
    }
    
    
    func execute(fetchRequestParameters: FetchListsRequestParameters, fetchRequestHeaders: FetchListRequestHeaders, completion: @escaping (Result<Array<Repository>, Error>) -> Void) {
        
        dependency.githubRepositoriesRepository.fetchRepositories(
            forUserWithToken: dependency.headers.token,
            perPage: dependency.parameters.perPage,
            pageNumber: dependency.parameters.pageNumber,
            completion: completion)
    }
}

final class FetchSearchedRepositoriesFromServerUseCase: FetchRepositoriesFromServerUseCase
{
    struct Dependency {
        let githubRepositoriesRepository:GithubRepositoriesRepository
        let parameters: FetchListsRequestParameters
        let searchTerm: String
    }
    let dependency: Dependency
    
    init(dependency: Dependency, parameters: FetchListsRequestParameters, headers: FetchListRequestHeaders) {
        self.dependency = dependency
    }
    
    func execute(fetchRequestParameters: FetchListsRequestParameters, fetchRequestHeaders: FetchListRequestHeaders, completion: @escaping (Result<Array<Repository>, Error>) -> Void) {
        dependency.githubRepositoriesRepository.fetchRepositories(
            withSearchTerm: dependency.searchTerm,
            perPage: dependency.parameters.perPage,
            pageNumber: dependency.parameters.pageNumber,
            completion: completion)
    }
}

struct FetchListsRequestParameters {
    let perPage: Int
    let pageNumber: Int
}

struct FetchListRequestHeaders{
    let token: String
}
