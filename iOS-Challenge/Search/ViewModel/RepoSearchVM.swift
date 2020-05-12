//
//  RepoSearchVM.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 1/30/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift

class RepoSearchVM{
    
    var queriesChanged = PublishSubject<[String: Any?]>()
    var queries = [String: Any?]()
    
    let bag = DisposeBag()
    var onChange = PublishSubject<State>()
    
    enum State {
        case success
        case failure(message: String)
    }
    
    var dataSource:[RepoSearchItems]? = []
    
    func search(Str:String){
        SearchServices.shared.SearchRepo(SearchText: Str)
            .subscribe(onNext: { (result) in
                //        self.isLoading = false
                switch result {
                case .success(let value):
                    print(value)
                    self.dataSource = value.items
                    self.onChange.onNext(.success)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.onChange.onNext(.failure(message: "ful"))
                }
            }).disposed(by: bag)
    }
    
}
