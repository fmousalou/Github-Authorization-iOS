//
//  RepositoryItemViewModel.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/8/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

protocol RepositoryItemViewModelInput {
}

protocol RepositoryItemViewModelOutput {
    var name: String? { get }
    var desc: String? { get }
    var language: String? { get }
    var watchers: Int? { get }
}

protocol RepositoryItemViewModel: RepositoryItemViewModelInput, RepositoryItemViewModelOutput {
    var repositoryId: Int? { get }
}

final class DefaultRepositoryItemViewModel: RepositoryItemViewModel {
    var name: String?
    var desc: String?
    var language: String?
    var watchers: Int?
    
    private let repository: Repository
    var repositoryId: Int? {
        return repository.id
    }
    init(repository: Repository) {
        self.repository = repository
        self.name = repository.full_name
        self.desc = repository.description
        self.language = repository.language
        self.watchers = repository.watchers
    }
}
