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
import Reachability

typealias githubService = MoyaProvider<GithubService>

class ReposViewModel {
    // Dependency
    private let githubService: MoyaProvider<GithubService>
    private let reachability: Reachability
    // MARK:- Init
    init(service: githubService = MoyaProvider<GithubService>()) {
        self.githubService = service
        self.reachability = try! Reachability()
        initReachability()
    }
    
    //MARK:- Variables
    //MARK: Closures
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var showAlertClosure: (()->())?
    
    //MARK: Computed Properties
    //Made it internal in order to access from testCase
    var repoViewModels: [RepoRowViewModel] = [RepoRowViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var suspendedRequestQ: String?
    
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
    //MARK: Reachability
    private func initReachability() {
        reachability.whenReachable = {
            [weak self] _ in
            guard let sSelf = self else { return}
            print("It's reachable")
            // If there is a suspended request
            guard let q = sSelf.suspendedRequestQ else { return}
            // Send request again
            sSelf.search(subject: q)
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Error in \(#function)")
        }
    }
    
    // Send request to search
    func search(subject: String) {
        guard reachability.connection != .unavailable else {
            Toast.shared.showInternetConnectionError()
            self.suspendedRequestQ = subject
            return
        }
        
        self.isLoading = true
        githubService.request(.search(subject: subject)) {
            [weak self]
            (result) in
            guard let sSelf = self else { return}
            switch result {
            case .success(let response):
                if let items = JSON(response.data)["items"].array {
                    sSelf.processFetched(repos: items)
                    sSelf.suspendedRequestQ = nil
                }else {
                    sSelf.alertMessage = "Try Again"
                }
            case .failure:
                sSelf.alertMessage = "I can't connect to the server"
            }
            sSelf.isLoading = false
        }
    }
    
    func getRowViewModel( at indexPath: IndexPath ) -> RepoRowViewModel {
        return repoViewModels[indexPath.row]
    }
    
    //Made it internal in order to access from testCase
    func processFetched( repos: [JSON] ) {
        var gits = [RepoRowViewModel]()
        repos.forEach { (repo) in
            let repoObj = try! JSONDecoder().decode(GitRepo.self, from: repo.rawData())
            let newRepo = RepoRowViewModel(nameText: repoObj.name ?? "No Name",
                                        imageUrl: repoObj.owner?.avatar_url,
                                        starsCount: String(repoObj.stars ?? 0),
                                        commitsURL: repoObj.commitsURL)
            gits.append(newRepo)
        }
        repoViewModels = gits
    }
}


struct RepoRowViewModel {
    let nameText: String
    let imageUrl: URL?
    let starsCount: String
    let commitsURL: String?
}
