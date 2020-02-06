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
    var pageIndex :Variable<Int>    = Variable(0)
    var LoadMore  :Variable<Void>   = Variable(())
    
    var searchItems:Variable<[Item]> = Variable([])
    var message : Variable<(String,String)?> = Variable(nil)
    // MARK: - initializer
    
    init() {
        doBindings()
    }
    
    // MARK: - bindings
    
    private func doBindings(){
        
        searchText
            .asObservable()
            .subscribe(onNext:{ [unowned self] text in
                self.pageIndex.value = 0
            }).disposed(by: disposeBag)
        
        LoadMore
            .asObservable()
            .subscribe(onNext:{ [unowned self] _ in
                self.pageIndex.value =  self.pageIndex.value + 1
            }).disposed(by: disposeBag)
        
        pageIndex
            .asObservable()
            .subscribe(onNext:{ [unowned self] _ in
                self.fetchReposetories(keyWord: self.searchText.value)
            }).disposed(by: disposeBag)
        
    }
    
    
    
    
    // MARK: - Fetch Data
    
    private func fetchReposetories(keyWord:String = ""){
        
        let observer = GitHubService.shared.FetchRepositories(keyWord:keyWord)
        
        observer
            .subscribe(onNext:{ [unowned self] response in
                if let items = response?.items {
                    self.searchItems.value = items
                }else{
                    self.message.value = ("Empty","Server couldn't answer, please try again")
                }
            }).disposed(by: disposeBag)
        
        observer
            .subscribe(onError:{ [unowned self] error in
                if let error = error as? ResponseError,error.statusCode != 404{
                    self.message.value = ("Error",error.message)
                }
            }).disposed(by: disposeBag)
    }
    
    
}
