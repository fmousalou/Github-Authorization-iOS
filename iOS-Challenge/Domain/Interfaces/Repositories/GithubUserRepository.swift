//
//  GithubUserRepository.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/8/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

protocol GithubUserRepository {
    func fetchUser(with toke: String, completion: @escaping (Result<Owner, Error>) -> Void)
}
