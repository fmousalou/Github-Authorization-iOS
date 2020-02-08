//
//  FetchUserDataFromServerUsecase.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/8/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

protocol FetchUserDataFromServerUsecase {
    func execute(userToken bearerToken: String ,completion: @escaping (Result<Owner, Error>) -> Void)
}


final class DefaultFetchUserDataFromServerUsecase: FetchUserDataFromServerUsecase {
    struct Dependency {
        let githubUserRepository: GithubUserRepository
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func execute(userToken bearerToken: String, completion: @escaping (Result<Owner, Error>) -> Void) {
        dependency.githubUserRepository.fetchUser(with: bearerToken, completion: completion)
    }
}
