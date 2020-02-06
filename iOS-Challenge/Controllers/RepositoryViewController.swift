//
//  RepositoryViewController.swift
//  iOS-Challenge
//
//  Created by anna on 11/15/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

enum RepositoriesSection:EnumProtocol{
    case respository(item:Item)
}

class RepositoryViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    
    private var disposeBag = DisposeBag()
    let profileView        = UIImageView(image: #imageLiteral(resourceName: "img_profilePlaceHolder"))
    private var dataSource     : RxTableViewSectionedReloadDataSource<MultiSectionGenericEnumModel<RepositoriesSection>>!
    
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
    
    
    
    // MARK: - Set UI
    
    private func UIConfig() {
        self.indicator.startAnimating()
        viewModel.searchText.value = ""
        setProfileImageButton()
        configurTableView()
    }
    
    // MARK: - Bind From ViewModel
    
    private func bindingFrom() {
        
        viewModel
            .message
            .asObservable()
            .filter({ $0 != nil})
            .subscribe(onNext:{ [unowned self] messageSet in
                guard let messageSet = messageSet else{ return }
                self.showAlert(title: messageSet.0, message: messageSet.1)
            }).disposed(by: disposeBag)
        
        viewModel
            .searchItems
            .asObservable()
            .map({ [unowned self] repositories in
                var items: [MultiSectionGenericEnumItem<RepositoriesSection>] = []
                for repository in repositories {
                    let item    = MultiSectionGenericEnumItem<RepositoriesSection>(type:MultiSectionGenericEnumType<RepositoriesSection>(type:RepositoriesSection.respository(item: repository)))
                    items.append(item)
                }
                let section = MultiSectionGenericEnumModel.init(header: "", items: items )
                return [section]
            })
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel
            .searchItems
            .asObservable()
            .skip(1)
            .map({ _ in return false})
            .bind(to: indicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - Bind To ViewModel
    
    private func bindingTo() {
        
        view
            .rx
            .tapGesture()
            .skip(1)
            .subscribe(onNext:{ [unowned self] _ in
                self.view.endEditing(true)
            }).disposed(by: disposeBag)
        
         profileView
                .rx
                .tapGesture()
                .skip(1)
                .subscribe(onNext:{ [unowned self] _ in
                    if let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileID"){
                        self.navigationController?.pushViewController(profileViewController, animated: true)
                    }
                }).disposed(by: disposeBag)
        
        
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
            .searchButtonClicked
            .subscribe(onNext:{ [unowned self] _ in
                self.view.endEditing(true)
                self.viewModel.searchText.value = self.searchBar.text ?? ""
            }).disposed(by: disposeBag)
        
        //        searchBar
        //            .rx
        //            .text
        //            .throttle(3.0, scheduler: MainScheduler.instance)
        //            .map({$0 ?? ""})
        //            .filter({ [unowned self] currentText in
        //                self.viewModel.searchText.value.compare(currentText) != .orderedSame
        //            })
        //            .distinctUntilChanged()
        //            .bind(to: viewModel.searchText)
        //            .disposed(by: disposeBag)
    }
    
    // MARK: - Custome Methods
    
    func configurTableView(){
        self.tableView.delegate   = nil
        self.tableView.dataSource = nil
        
        dataSource = RxTableViewSectionedReloadDataSource<MultiSectionGenericEnumModel<RepositoriesSection>>(configureCell: {[unowned self] (dataSource, tableView, indexPath, item) -> UITableViewCell in
            
            switch (item.type.type) {
            case .respository(let item):
                let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryCell
                cell.configur(item: item)
                return cell
            }
        })
    }
    
    fileprivate func setProfileImageButton() {
        profileView.widthAnchor.constraint(equalToConstant: 40).isActive  = true
        profileView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let rightBarButton = UIBarButtonItem(customView: profileView)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
}
