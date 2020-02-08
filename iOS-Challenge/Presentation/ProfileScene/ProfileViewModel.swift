//
//  ProfileViewModel.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/7/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

protocol ProfileViewModelInput { }

protocol ProfileViewModelOutput {
    var title: String { get }
    var error: Observable<String> { get }
    var user: Observable<Owner?> { get }
    
    var name: String { get }
    var company: String { get }
    var avatarURL: String { get }
    var login: String { get }
}

protocol ProfileViewModel: ProfileViewModelInput, ProfileViewModelOutput {
    
}

final class DefaultProfileViewModel: ProfileViewModel {
    var avatarURL: String {
      return user.value?.avatar_url ?? ""
    }
    
    var login: String{
        return user.value?.login ?? ""
    }
    
    var name: String {
        return user.value?.name ?? ""
    }
    
    var company: String{
        return user.value?.company ?? ""
    }
    
    var user: Observable<Owner?> = Observable(nil)
    
    var title: String = "Profile"
    
    var error: Observable<String> = Observable("")
    struct Dependency {
        let fetchUserDataFromServerUsecase:FetchUserDataFromServerUsecase
        let bearerTokenRepository: BearerTokenRepository
    }
    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
        self.fetchData()
    }
    
    func fetchData() {
        dependency.bearerTokenRepository.fetch { [weak self] (result) in
            switch result{
            case .success(let token):
                self?.fetchData(with: token)
            case .failure(let err):
                self?.error.value = err.localizedDescription
            }
        }
    }
    func fetchData(with token: String) {
        LoadingUtility.showLoading()
        self.dependency.fetchUserDataFromServerUsecase.execute(userToken: token) { [weak self] (serverResult) in
            LoadingUtility.hideLoading()
            switch serverResult {
            case .success(let owner): self?.user.value = owner
            case .failure(let err): self?.error.value = err.localizedDescription

            }
        }
    }
}
