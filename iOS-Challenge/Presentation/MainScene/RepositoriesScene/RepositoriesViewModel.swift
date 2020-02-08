//
//  RepositoriesViewModel.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/5/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

enum RepositoriesViewModelRoute {
    case initial
    case showCommits(repo: Repository)
    case profile
    case logout
}

protocol RepositoriesViewModelInput {
    func search(_ text: String)
    func didSelect(item: RepositoryItemViewModel)
    func loadNextPage()
    func logout()
    func showProfile()
}

protocol RepositoriesViewModelOutput {
    var route: Observable<RepositoriesViewModelRoute> { get }
    var items: Observable<[RepositoryItemViewModel]> { get }
    
    var title: String { get }
    var error: Observable<String> { get }
    var numberOfRows: Int { get }
    func item(at indexPath: IndexPath) -> RepositoryItemViewModel
}
protocol RepositoriesViewModel: RepositoriesViewModelInput, RepositoriesViewModelOutput {}


final class DefaultRepositoriesViewModel: RepositoriesViewModel
{
    func logout() {
        dependency.logoutUserUseCase.execute { [weak self] (result) in
            switch result {
            case .success(_):
                self?.route.value = .logout
            case .failure(let err):
                self?.error.value = err.localizedDescription
            }
        }
    }
    
    func showProfile() {
        route.value = .profile
    }
    
    private var searchTerm = ""
    private var loading = false
    private var isThereMoreData = true
    
    var numberOfRows: Int {
        return items.value.count
    }
    
    func item(at indexPath: IndexPath) -> RepositoryItemViewModel {
        return items.value[indexPath.row]
    }
    
    func didSelect(item: RepositoryItemViewModel) {
        route.value = .showCommits(repo: item.repository)
    }
    
    var route: Observable<RepositoriesViewModelRoute> = Observable(.initial)
    var items: Observable<[RepositoryItemViewModel]> = Observable([])
    var title: String = "Repositories"
    var error: Observable<String> = Observable("")
    
    struct Dependency {
        let fetchRepositoriesFromServerUseCase: FetchRepositoriesFromServerUseCase
        let logoutUserUseCase: LogoutUserUseCase
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    func loadNextPage() {
        fetchData(with: FetchListsRequestParameters(perPage: 10, pageNumber: (items.value.count / 10 ) + 1, searchTerm: searchTerm))
    }
    
    func search(_ text: String) {
        searchTerm = text
        isThereMoreData = true
        self.items.value = []
        fetchData(with: FetchListsRequestParameters(perPage: 10, pageNumber: 1, searchTerm: text))
    }
    
    func fetchData(with fetchListsRequestParameters: FetchListsRequestParameters) {
        guard isThereMoreData else { return }
        guard loading == false else { return }
        loading = true
        dependency.fetchRepositoriesFromServerUseCase.execute(fetchRequestParameters: fetchListsRequestParameters, fetchRequestHeaders: nil) {[weak self] (result: Result<Array<Repository>, Error>) in
            self?.loading = false
            switch result{
            case .success(let repos):
                if fetchListsRequestParameters.pageNumber < 2 && repos.count < 1 {
                    self?.error.value = "No result"
                }
                if repos.count < 1 {
                    self?.isThereMoreData = false
                }
                self?.appand(repos)
            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
            
        }
    }
    
    func appand(_ repos:Array<Repository>) {
        items.value = items.value + repos.map({ (repo) -> RepositoryItemViewModel in
            return DefaultRepositoryItemViewModel(repository: repo)
        })
    }
}
