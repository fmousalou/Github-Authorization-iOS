//
//  LogoutUserUseCase.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/8/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

protocol LogoutUserUseCase {
    func execute(completion: @escaping (Result<Bool, Error>) -> Void)
}

final class DefaultLogoutUserUseCase:LogoutUserUseCase {
    struct Dependency {
        let bearerTokenRepository: BearerTokenRepository
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func execute(completion: @escaping (Result<Bool, Error>) -> Void) {
        dependency.bearerTokenRepository.delete(completion: completion)
    }
}
