//
//  ProfileVC.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 1/28/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit
class ProfileVC:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        run()
    }
    
    let bag = DisposeBag()
    
    
    
    func run(){
        UserService.shared.getUserProfile()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:
                { (result) in
                    //            self.isLoading = false
                    
                    switch result {
                    case .success(let value):
                        break
                    case .failure(let error):
                        break
                    }
            }).disposed(by: bag)
        
    }
        
}
