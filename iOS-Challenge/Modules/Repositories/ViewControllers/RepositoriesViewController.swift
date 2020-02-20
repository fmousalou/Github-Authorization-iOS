//
//  RepositoriesViewController.swift
//  iOS-Challenge
//
//  Created by Erfan Andesta on 2/18/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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
        return refreshControl
    }()
    private var viewModel = RepositoriesViewModel()
    private var disposeBag = DisposeBag()
    //MARK: - View's LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Functions -
    fileprivate func setupView() {
        searchController.dimsBackgroundDuringPresentation = false
        tableView.keyboardDismissMode = .onDrag
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableHeaderView = searchBar
        tableView.refreshControl = customRefreshControl
        customRefreshControl.addTarget(self, action: #selector(getRepositories), for: .valueChanged)
        searchBar.rx.text.orEmpty
            .throttle(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged().subscribe(onNext: { (query) in
            self.getRepositories(withQuery: query)
            }).disposed(by: disposeBag)
    }
    @objc fileprivate func getRepositories(withQuery query: String) {
        if query == "" { return }
        viewModel.getRepositories(forQuery: query) { [weak self] (result) in
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
        searchController.isActive = false
        let repo = viewModel.repositories[indexPath.row]
        navigateToCommits(forOwner: repo.owner?.login ?? "", forRepo: repo.name ?? "")
    }
    fileprivate func navigateToCommits(forOwner owner: String, forRepo repo: String) {
        if let commitsController = UIStoryboard(name: "Commits", bundle: nil).instantiateInitialViewController() as? CommitsTableViewController {
            commitsController.setupContent(owner: owner, repo: repo)
            navigationController?.pushViewController(commitsController, animated: true)
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
