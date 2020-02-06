//
//  LogInViewModel.swift
//  iOS-Challenge
//
//  Created by anna on 11/15/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift

class LogInViewModel{
    
    private var disposeBag = DisposeBag()

    var message : Variable<(String,String)?> = Variable(nil)
    
    
    init() {
        
    }
    
    func callLogin(code:String){
        let observer = GitHubService.shared.login(code: code)
               
               observer
                   .subscribe(onNext:{ [unowned self] response in
                      
                   }).disposed(by: disposeBag)
               
               observer
                   .subscribe(onError:{ [unowned self] error in
                       if let error = error as? ResponseError,error.statusCode != 404{
                           self.message.value = ("Error",error.message)
                       }
                   }).disposed(by: disposeBag)
        
    }
    
    
}
