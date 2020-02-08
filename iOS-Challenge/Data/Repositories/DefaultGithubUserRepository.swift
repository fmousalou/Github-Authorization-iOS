//
//  DefaultGithubUserRepository.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/8/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

final class DefaultGithubUserRepository: GithubUserRepository {
    struct Dependency {
        let dataTransferService: DataTransferService
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func fetchUser(with token: String, completion: @escaping (Result<Owner, Error>) -> Void) {
        let endpoint = APIEndpoints.user(with: token)
        dependency.dataTransferService.request(with: endpoint, completion: completion)
    }
}
