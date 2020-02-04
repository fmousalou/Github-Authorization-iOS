//
//  CommitViewController.swift
//  iOS-Challenge
//
//  Created by anna on 11/15/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift


class CommitViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    
    private lazy var viewModel :CommitViewModel = {
        return CommitViewModel()
    }()
    
    // MARK: - Initializer
    
    
    
    // MARK: - Default Delegates
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        UIConfig()
        bindingFrom()
        bindingTo()
    }
    
    // MARK: - Custome Methods
    
    
    // MARK: - Set UI
    
    private func UIConfig() {
        
    }
    
    // MARK: - Bind From ViewModel
    
    private func bindingFrom() {
        
    }
    
    
    // MARK: - Bind To ViewModel
    
    private func bindingTo() {
        
    }
    
    
}
