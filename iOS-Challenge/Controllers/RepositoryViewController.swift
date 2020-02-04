//
//  RepositoryViewController.swift
//  iOS-Challenge
//
//  Created by anna on 11/15/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import UIKit
import RxSwift


class RepositoryViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    
    private var disposeBag = DisposeBag()
    
    private lazy var viewModel :RepositoryViewModel = {
        return RepositoryViewModel()
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
        viewModel.searchText.value = ""
        
    }
    
    // MARK: - Bind From ViewModel
    
    private func bindingFrom() {
        
    }
    
    
    // MARK: - Bind To ViewModel
    
    private func bindingTo() {
        
        searchBar
            .rx
            .textDidBeginEditing
            .asDriver()
            .map({true})
            .drive(indicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        searchBar
            .rx
            .textDidEndEditing
            .asDriver()
            .map({false})
            .drive(indicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        searchBar
            .rx
            .text
            .throttle(3.0, scheduler: MainScheduler.instance)
            .map({$0 ?? ""})
            .filter({ [unowned self] currentText in
                self.viewModel.searchText.value.compare(currentText) != .orderedSame
            })
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
    }
    
    
}
