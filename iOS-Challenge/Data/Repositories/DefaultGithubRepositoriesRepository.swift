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
    func fetchRepositories(forUserWithToken token: String, perPage: Int, pageNumber: Int, completion: @escaping (Result<Array<Repository>, Error>) -> Void) {
        fatalError()
    }
    
    func fetchRepositories(withSearchTerm term: String, perPage: Int, pageNumber: Int, completion: @escaping (Result<Array<Repository>, Error>) -> Void) {
        fatalError()
    }
}
