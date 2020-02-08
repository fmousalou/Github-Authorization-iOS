//
//  DefaultGithubCommitsRepository.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/8/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

final class DefaultGithubCommitsRepository: GithubCommitsRepository
{
    struct Dependency {
        let dataTransferService: DataTransferService
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func fetchCommits(for repository: Repository, perPage: Int, pageNumber: Int, completion: @escaping (Result<Array<Commit>, Error>) -> Void) {
        dependency.dataTransferService.request(with: APIEndpoints.commits(for: repository, perPage: perPage, pageNumber: pageNumber), completion: completion)
    }
}
