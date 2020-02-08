//
//  GithubCommitsRepository.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/8/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

protocol GithubCommitsRepository {
    func fetchCommits(for repository: Repository, perPage: Int, pageNumber: Int, completion: @escaping (Result<Array<Commit>, Error>) -> Void)

}
