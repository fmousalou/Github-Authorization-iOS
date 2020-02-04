//
//  GitHubService.swift
//  iOS-Challenge
//
//  Created by anna on 11/13/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift
import Moya

public final class GitHubService {
    
    static let shared = GitHubService()
    
    private let provider   = MoyaProvider<GitHubAPI>(endpointClosure: MoyaProvider.customeEndpointMapping,plugins: [NetworkLoggerPlugin()])
    private let disposeBag = DisposeBag()
    
    init() { }
    
    func FetchRepositories() ->  Observable<(String , Int ,SearchResult?)>
    {
        return  provider
            .rx
            .request(.search(keyWord: "", sort: "", order: "",page: "0"))
            .timeout(10, scheduler: MainScheduler.instance)
            .objectWithStatus(SearchResult.self)
        
    }
    
    
    
}
