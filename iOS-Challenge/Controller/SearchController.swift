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
import SwiftyJSON

class SearchController: UIViewController, NVActivityIndicatorViewable, UITableViewDelegate {
    
    //MARK:- Variables
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchResults = [GitRepo]() {
        didSet {
            searchView.tblView.backgroundView = nil
            searchView.tblView.reloadData()
        }
    }
    // Search Variables
    private var searchView = SearchView()
    
    //MARK:- LifeCycle
    override func loadView() {
        self.view = searchView
        setupViews()
        setupSearchBar()
    }
    
    //MARK:- Setups
    private func setupViews() {
        self.title = "Repos"
        searchView.tblView.delegate = self as UITableViewDelegate
        searchView.tblView.dataSource = self as UITableViewDataSource
        searchView.tblView.register(RepoTableviewCell.self, forCellReuseIdentifier: "cell")
    }
    private func setupSearchBar() {
        searchController.searchBar.delegate = self as UISearchBarDelegate
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search Github.com"
        definesPresentationContext = true
        searchView.tblView.tableHeaderView = searchController.searchBar
    }
}

// Tableview
extension SearchController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? RepoTableviewCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = searchResults[indexPath.item].name
        cell.imgView.sd_setImage(with: searchResults[indexPath.item].owner?.avatar_url)
        cell.starCountLabel.text = String(searchResults[indexPath.item].stars!)

        return cell
    }
}

// Search
extension SearchController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchFor = searchBar.text else { return}
        // Call mvvm fetch
        fetchResults(for: searchFor)
    }
    
    func fetchResults(for aim: String) {
        let gitService = MoyaProvider<GithubService>()
        startAnimating(message: "Connecting to the server")
        
        gitService.request(.search(subject: aim)) {
            [weak self]
            (result) in
            guard let sSelf = self else { return}
            switch result {
            case .success(let response):
                if let items = JSON(response.data)["items"].array {
                    var gits = [GitRepo]()
                    items.forEach { (json) in
                        let result = try! JSONDecoder().decode(GitRepo.self, from: json.rawData())
                        gits.append(result)
                    }
                    sSelf.searchResults = gits
                }
            case .failure:
                Toast.shared.showConnectionError()
            }
            sSelf.stopAnimating()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResults.removeAll()
    }
}
