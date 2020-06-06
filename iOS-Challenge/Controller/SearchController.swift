//
//  SearchController.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import Moya
import NVActivityIndicatorView

class SearchController: UIViewController, NVActivityIndicatorViewable, UITableViewDelegate, UISearchBarDelegate {

    //MARK:- Variables
    weak var coordinator: MainCoordinator?
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchView = SearchView()
    private lazy var viewModel: ReposViewModel = {
        return ReposViewModel()
    }()
    
    //MARK:- LifeCycle
    override func loadView() {
        self.view = searchView
        setupViews()
        setupSearchBar()
        initVM()
    }
    
    deinit {
        print("There isn't retain cycle in \(#file)")
    }
    
    //MARK:- Setups
    private func setupViews() {
        self.title = "Search"
        searchView.tblView.delegate = self as UITableViewDelegate
        searchView.tblView.dataSource = self as UITableViewDataSource
        searchView.tblView.register(RepoTableviewCell.self, forCellReuseIdentifier: "cell")
        
        // Config Left bar button
        let leftBarBtn = searchView.leftBarBtn
        leftBarBtn.target = self
        self.navigationItem.leftBarButtonItem = leftBarBtn
        navigationItem.leftBarButtonItem?.title = nil
    }
    private func setupSearchBar() {
        searchController.searchBar.delegate = self as UISearchBarDelegate
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search Github.com"
        definesPresentationContext = true
        searchView.tblView.tableHeaderView = searchController.searchBar
    }
    private func initVM() {
        // TODO: Do it with RXSwift
        
        // Dear visitor 👋🏼 I know RXSwift is better and easier but
        // usage of RXSwift is a little bit tricky
        // and I don't risk, because It might got stuck in bugs
        // and I'll loose the time for debugging
        
        
        // Naive binding
        
        // Show AlertMessage
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    Toast.shared.showIn(body: message)
                }
            }
        }
        
        // Stop and Start animation
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.startAnimating(message: "Connecting to the server")
                }else {
                    self?.stopAnimating()
                }
            }
        }
        
        // Reload Table
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.searchView.tblView.backgroundView = nil
                self?.searchView.tblView.reloadData()
                self?.searchController.dismiss(animated: true)
            }
        }
    }
    
    //MARK:- Functions
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let searchFor = searchBar.text else { return}
            // Call mvvm fetch
            viewModel.search(subject: searchFor)
        }
    @objc func showUserInfoPage() {
        coordinator?.profile()
    }
}

// Tableview DataSource
// TODO: Move it to another class and write test
extension SearchController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? RepoTableviewCell else {
            return UITableViewCell()
        }
        
        let cellVM = viewModel.getRowViewModel( at: indexPath )
        cell.repoViewModel = cellVM
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowVM = viewModel.getRowViewModel( at: indexPath )
        
        guard let commitsURL = rowVM.commitsURL,
            let commitsPath = commitsURL.commitsURLPath // If has valid commits path
            else {
                Toast.shared.showIn(body: "There isn't commits")
                return }
        if viewModel.isAllowSegue { // If internet connected
            coordinator?.commits(urlPath: commitsPath)
        }
    }
}
