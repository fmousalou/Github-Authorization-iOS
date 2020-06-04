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


class SearchController: UIViewController, NVActivityIndicatorViewable, UITableViewDelegate {
    
    //MARK:- Variables
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchResults = [GitRepo]() {
        didSet {
            searchView.tblView.reloadData()
        }
    }
    private var searchView = SearchView()
    private var previousRun = Date()
    private let minInterval = 0.5
    
    //MARK:- LifeCycle
    override func loadView() {
        self.view = searchView
        setupViews()
        searchView.tblView.tableFooterView = UIView()
        setupSearchBar()
        setupTableViewBackgroundView()
    }
    
    //MARK:- Setups
    private func setupViews() {
        searchView.tblView.delegate = self as UITableViewDelegate
        searchView.tblView.dataSource = self as UITableViewDataSource
        searchView.tblView.register(RepoTableviewCell.self, forCellReuseIdentifier: "cell")
    }
    private func setupSearchBar() {
        searchController.searchBar.delegate = self as UISearchBarDelegate
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search any Topic"
        definesPresentationContext = true
        searchView.tblView.tableHeaderView = searchController.searchBar
    }
    private func setupTableViewBackgroundView() {
       let backgroundViewLabel = UILabel(frame: .zero)
       backgroundViewLabel.textColor = .darkGray
       backgroundViewLabel.numberOfLines = 0
        backgroundViewLabel.textAlignment = .center
       backgroundViewLabel.text = "Use the top sarch bar \nand find your favorite Repo 😍"
        searchView.tblView.backgroundView = backgroundViewLabel
    }
    
}

extension SearchController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? RepoTableviewCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = searchResults[indexPath.item].name

        return cell
    }
}

extension SearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults.removeAll()
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            return
        }
        
        if Date().timeIntervalSince(previousRun) > minInterval {
            previousRun = Date()
            fetchResults(for: textToSearch)
        }
    }
    
    func fetchResults(for text: String) {
        print("Text Searched: \(text)")
//        apiFetcher.search(searchText: text, completionHandler: {
//            [weak self] results, error in
//            if case .failure = error {
//                return
//            }
//
//            guard let results = results, !results.isEmpty else {
//                return
//            }
//
//            self?.searchResults = results
//        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResults.removeAll()
    }
}



struct GitRepo {
    var name: String?
}
