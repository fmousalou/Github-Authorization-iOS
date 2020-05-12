//
//  RepoSearchVC.swift
//  iOS-Challenge
//
//  Created by Emad Beyrami on 1/30/1399 AP.
//  Copyright © 1399 AP Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift
class RepoSearchVC: UITableViewController {
    let bag = DisposeBag()
    @IBOutlet weak var searchBar: UISearchBar!{
        didSet{
            self.searchBar.delegate = self
            searchBar.barTintColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0.7)
            searchBar.backgroundColor = .clear
            searchBar.layer.borderWidth = 0
            searchBar.tintColor = UIColor(red: 251/255, green: 75/255, blue: 99/255, alpha: 1.000)
            searchBar.placeholder = "Search Repo"
            searchBar.semanticContentAttribute = .forceLeftToRight
            searchBar.setValue("Cancel", forKey:"cancelButtonText")
            searchBar.searchBarStyle = .minimal
            if #available(iOS 13.0, *) {
                searchBar.searchTextField.textAlignment = .left
            }
            self.searchBar.semanticContentAttribute = .forceLeftToRight
        }
    }
    
    let vm = RepoSearchVM()
    
    private var pendingSearchWorkItem: DispatchWorkItem?
    
    
    
    private var isSearchBarEmpty: Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
        self.tableView.register(UINib(nibName: "RepoCell", bundle: nil), forCellReuseIdentifier: "RepoCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.refreshControl = UIRefreshControl()
        
        if let refreshControl = self.refreshControl{
            refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        }
    }
    
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        pendingSearchWorkItem?.cancel()
        let searchText = searchBar.text
       let searchWorkItem = DispatchWorkItem {
        if searchText?.count ?? 0 > 0 {
            self.vm.search(Str: searchText ?? "")
           }
       }
        pendingSearchWorkItem = searchWorkItem
    }
    
    var searchDelay = 900
    
    
    func subscribe() {
        self.vm.onChange.subscribe(onNext: { (state) in
            switch state {
            case .success:
                self.refreshControl!.endRefreshing()
                self.tableView.reloadData()
            case .failure(let message):
                self.tableView.refreshControl?.endRefreshing()
                print(message)
            }
        }).disposed(by: bag)
    }
    
    private func filterResultForSearchText(_ searchText: String) {
        pendingSearchWorkItem?.cancel()
        let searchWorkItem = DispatchWorkItem {
            if searchText.count > 0 {
                self.tableView.refreshControl!.beginRefreshing()
                self.vm.search(Str: searchText)
                
            }
        }
        pendingSearchWorkItem = searchWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(searchDelay), execute: searchWorkItem)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.dataSource?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell") as? RepoCell
        if let data = self.vm.dataSource {
            let cellData = data[indexPath.row]
            cell?.config(name: cellData.full_name ?? "fg" , lang: cellData.language ?? "gfd" , Fullname: cellData.description ?? "dfg", Star: cellData.stargazers_count ?? 0)
        }else{
            self.tableView.setEmptyMessage("Search For Repo...")
        }
        return cell ?? UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        Router.goTo.CommitList(target: self)
    }
    
}

extension RepoSearchVC:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField , let clearButton = searchTextField.value(forKey: "_clearButton")as? UIButton {
            
            if searchText.count > 1 {
                self.refreshControl!.beginRefreshing()
                filterResultForSearchText(searchText)
            }
        }
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.searchBar.showsCancelButton = true
            self.searchBar.setValue("انصراف", forKey: "cancelButtonText")
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            self.searchBar.showsCancelButton = false
            self.searchBar.resignFirstResponder()
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            DispatchQueue.main.async {
                self.vm.dataSource = []
                self.searchBar.resignFirstResponder()
                
            }
        }
    }
}

