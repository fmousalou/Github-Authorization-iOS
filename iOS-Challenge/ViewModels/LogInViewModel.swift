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
    var gotoRepository:PublishSubject<Void> = PublishSubject()
    var message : Variable<(String,String)?> = Variable(nil)
    
    
    init() {
        
    }
    
    func callLogin(code:String){
        let observer = GitHubService.shared.login(code: code)

               observer
                   .subscribe(onNext:{ [unowned self] response in

                    if let token = response?["access_token"] as? String{
                        let userDataHelper = UserDataHelper()
                        userDataHelper.setToken(token: token)
                        print("token=>\(token)")
                        self.gotoRepository.onNext(())
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
