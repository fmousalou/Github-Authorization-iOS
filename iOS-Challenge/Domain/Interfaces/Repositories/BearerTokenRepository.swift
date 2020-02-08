//
//  BearerTokenRepository.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

protocol BearerTokenRepository {
    func save(token: String, completion: ((Result<Bool, Error>) -> Void)?)
    func fetch(completion: @escaping (Result<String, Error>) -> Void)
    func delete(completion: ((Result<Bool, Error>) -> Void)?)
}
