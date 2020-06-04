//
//  ReposViewModel.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

typealias githubService = MoyaProvider<GithubService>
class ReposViewModel {
    // Dependency
    private let githubService: MoyaProvider<GithubService>
    // MARK:- Init
    init(service: githubService = MoyaProvider<GithubService>()) {
        self.githubService = service
    }
    
    //MARK:- Variables
    //MARK: Closures
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var showAlertClosure: (()->())?
    
    //MARK: Computed Properties
    private var repoViewModels: [RepoViewModel] = [RepoViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var numberOfCells: Int {
        return repoViewModels.count
    }
    
    //MARK:- Functions
    // Send request to search
    func search(subject: String) {
        self.isLoading = true
        githubService.request(.search(subject: subject)) {
            [weak self]
            (result) in
            guard let sSelf = self else { return}
            switch result {
            case .success(let response):
                if let items = JSON(response.data)["items"].array {
                    sSelf.processFetched(repos: items)
                }else {
                    sSelf.alertMessage = "Try Again"
                }
            case .failure:
                sSelf.alertMessage = "I can't connect to the server"
            }
            sSelf.isLoading = false
        }
    }
    
    func getRowViewModel( at indexPath: IndexPath ) -> RepoViewModel {
        return repoViewModels[indexPath.row]
    }
    
    private func processFetched( repos: [JSON] ) {
        var gits = [RepoViewModel]()
        repos.forEach { (repo) in
            let repoObj = try! JSONDecoder().decode(GitRepo.self, from: repo.rawData())
            let newRepo = RepoViewModel(nameText: repoObj.name ?? "No Name",
                                        imageUrl: repoObj.owner?.avatar_url,
                                        starsCount: String(repoObj.stars ?? 0),
                                        commitsURL: repoObj.commitsURL)
            gits.append(newRepo)
        }
        repoViewModels = gits
    }
}


struct RepoViewModel {
    let nameText: String
    let imageUrl: URL?
    let starsCount: String
    let commitsURL: String?
}
