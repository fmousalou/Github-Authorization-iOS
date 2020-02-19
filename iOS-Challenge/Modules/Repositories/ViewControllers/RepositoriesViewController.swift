//
//  RepositoriesViewController.swift
//  iOS-Challenge
//
//  Created by Erfan Andesta on 2/18/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class RepositoriesViewController: UITableViewController {

    //MARK: - Outlets -
    
    //MARK: - Actions -
    
    //MARK: - Vars -
    private var searchController = UISearchController(searchResultsController: nil)
    private var searchBar: UISearchBar {
        return searchController.searchBar
    }
    private var customRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getRepositories), for: .valueChanged)
        return refreshControl
    }()
    private var viewModel = RepositoriesViewModel()
    
    //MARK: - View's LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getRepositories()
    }
    
    //MARK: - Functions -
    fileprivate func setupView() {
        searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.keyboardDismissMode = .onDrag
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableHeaderView = searchBar
        tableView.refreshControl = customRefreshControl
    }
    @objc fileprivate func getRepositories() {
        if searchBar.text == "" { return }
        viewModel.getRepositories(forQuery: searchBar.text ?? "") { [weak self] (result) in
            switch result {
            case .success(_):
                self?.tableView.reloadData()
            case .failure(let error):
                self?.handleError(error: error)
            }
            self?.refreshControl?.endRefreshing()
        }
    }
}
//MARK: - TableView DataSource -
extension RepositoriesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = viewModel.repositories[indexPath.row].name
            return cell
        } else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            cell.textLabel?.text = viewModel.repositories[indexPath.row].name
            cell.detailTextLabel?.text = viewModel.repositories[indexPath.row].owner?.login
            return cell
        }
    }
}
//MARK: - TableView Delegate -
extension RepositoriesViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
//MARK: - searchController Delegate -
extension RepositoriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getRepositories()
    }
}
