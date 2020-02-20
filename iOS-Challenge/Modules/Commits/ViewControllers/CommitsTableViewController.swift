//
//  CommitsTableViewController.swift
//  iOS-Challenge
//
//  Created by erfan on 12/1/1398 AP.
//  Copyright © 1398 Farshad Mousalou. All rights reserved.
//

import UIKit

class CommitsTableViewController: UITableViewController {
    
    //MARK: - Vars -
    private var customRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    private var viewModel = CommitsViewModel(owner: "", repo: "")
    //MARK: - View's LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getCommits()
    }
    
    //MARK: - Functions -
    
    func setupContent(owner: String, repo: String) {
        viewModel = CommitsViewModel(owner: owner, repo: repo)
    }
    fileprivate func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.refreshControl = customRefreshControl
        customRefreshControl.addTarget(self, action: #selector(getCommits), for: .valueChanged)
    }
    
    @objc fileprivate func getCommits() {
        viewModel.getCommits(completionHandler: { [weak self] (result) in
            switch result {
            case .success(_):
                self?.tableView.reloadData()
            case .failure(let error):
                self?.handleError(error: error)
            }
            self?.refreshControl?.endRefreshing()
            
        })
    }
}
//MARK: - TableView DataSource -
extension CommitsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.commits.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = viewModel.commits[indexPath.row].commit?.message
            return cell
        } else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            cell.textLabel?.text = viewModel.commits[indexPath.row].commit?.message
            cell.detailTextLabel?.text = viewModel.commits[indexPath.row].commit?.committer?.name
            return cell
        }
    }
}
//MARK: - TableView Delegate -
extension CommitsTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
