//
//  FetchCommitsFromServer.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/8/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

protocol FetchCommitsFromServerUseCase {
    func execute(fetchListsRequestParameters: FetchCommitListsRequestParameters, fetchRequestHeaders: FetchListRequestHeaders?, completion: @escaping (Result<Array<Commit>, Error>) -> Void)
}


class DefaultFetchCommitsFromServerUseCase: FetchCommitsFromServerUseCase {
    struct Dependency {
        let githubCommitsRepository:GithubCommitsRepository
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func execute(fetchListsRequestParameters: FetchCommitListsRequestParameters, fetchRequestHeaders: FetchListRequestHeaders?, completion: @escaping (Result<Array<Commit>, Error>) -> Void) {
        dependency.githubCommitsRepository.fetchCommits(
            for: fetchListsRequestParameters.repository,
            perPage: fetchListsRequestParameters.perPage,
            pageNumber: fetchListsRequestParameters.pageNumber,
            completion: completion)
    }
}

struct FetchCommitListsRequestParameters {
    let perPage: Int
    let pageNumber: Int
    let repository: Repository
}
