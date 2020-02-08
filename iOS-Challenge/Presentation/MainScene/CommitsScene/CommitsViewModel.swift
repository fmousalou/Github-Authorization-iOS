//
//  CommitsViewModel.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/8/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

protocol CommitsViewModelInput {
    func loadNextPage()
}

protocol CommitsViewModelOutput {
    var items: Observable<[CommitItemViewModel]> { get }
    
    var title: String { get }
    var error: Observable<String> { get }
    var numberOfRows: Int { get }
    func item(at indexPath: IndexPath) -> CommitItemViewModel
}

protocol CommitsViewModel: CommitsViewModelInput, CommitsViewModelOutput {
    var repository: Repository { get }
}

final class DefaultCommitsViewModel: CommitsViewModel
{
    private var loading = false
    private var isThereMoreData = true

    struct Dependency {
        let fetchCommitsFromServerUseCase: FetchCommitsFromServerUseCase
    }
    
    let dependency: Dependency
    init(dependency: Dependency, repository: Repository) {
        self.dependency = dependency
        self.repository = repository
        self.firstFetch()
    }

    var repository: Repository
    
    var items: Observable<[CommitItemViewModel]> = Observable([])
    
    var title: String = "Commits"
    
    var error: Observable<String> = Observable("")
    
    var numberOfRows: Int {
        return items.value.count
    }
    
    func item(at indexPath: IndexPath) -> CommitItemViewModel {
        return items.value[indexPath.row]
    }
    
    func loadNextPage() {
        fetchData(with: FetchCommitListsRequestParameters(perPage: 10, pageNumber: (items.value.count / 10 ) + 1, repository: repository))
    }
    
    func firstFetch() {
        isThereMoreData = true
        self.items.value = []
        fetchData(with: FetchCommitListsRequestParameters(perPage: 10, pageNumber: 1, repository: repository))
    }
    
    func fetchData(with fetchCommitListsRequestParameters: FetchCommitListsRequestParameters) {
        guard isThereMoreData else { return }
        guard loading == false else { return }
        loading = true
        dependency.fetchCommitsFromServerUseCase.execute(fetchListsRequestParameters: fetchCommitListsRequestParameters, fetchRequestHeaders: nil) {[weak self] (result: Result<Array<Commit>, Error>) in
            self?.loading = false
            switch result{
            case .success(let newCommits):
                if fetchCommitListsRequestParameters.pageNumber < 2 && newCommits.count < 1 {
                    self?.error.value = "No result"
                }
                if newCommits.count < 1 {
                    self?.isThereMoreData = false
                }
                self?.appand(newCommits)
            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
            
        }
    }
    
    func appand(_ commits:Array<Commit>) {
        items.value = items.value + commits.map({ (com) -> CommitItemViewModel in
            return DefaultCommitItemViewModel(commit: com)
        })
    }
}

