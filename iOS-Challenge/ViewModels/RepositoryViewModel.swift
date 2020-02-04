//
//  RepositoryViewModel.swift
//  iOS-Challenge
//
//  Created by anna on 11/15/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift

class RepositoryViewModel{
    
    private var disposeBag = DisposeBag()
    
    var searchText:Variable<String> = Variable("")
    
    // MARK: - initializer
    
    init() {
        doBindings()
    }
    
    // MARK: - bindings
    
    private func doBindings(){
        
        searchText
            .asObservable()
            .subscribe(onNext:{ [unowned self] text in
                self.fetchReposetories(keyWord: text)
            }).disposed(by: disposeBag)
        
        
        
    }
    
    
    
    
    // MARK: - Fetch Data
    
    private func fetchReposetories(keyWord:String = ""){
        
        let observer = GitHubService.shared.FetchRepositories()
        
        observer
            .subscribe(onNext:{ [unowned self] response in
                print(response)
            }).disposed(by: disposeBag)
        
        observer
            .subscribe(onError:{ [unowned self] error in
                if let error = error as? ResponseError{
                    //                switch error.statusCode {
                    //                case ResponseStatus.unAuthorized.rawValue:
                    //                    UIApplication.shared.logOut()
                    //                    break
                    //                default:
                    //                    break
                    //                }
                }
            }).disposed(by: disposeBag)
    }
    
    
}
