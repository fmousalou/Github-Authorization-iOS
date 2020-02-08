//
//  RepositoriesViewController.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/5/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController, StoryboardInstantiable, Alertable
{
    var viewModel: RepositoriesViewModel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    var searchController = UISearchController(searchResultsController: nil)
    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Git Repository"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        bind(to: viewModel)
        setupSearchController()
    }
    func bind(to viewModel: RepositoriesViewModel) {
        viewModel.error.observe(on: self) { [weak self] error in
            guard error.isEmpty == false else { return }
            self?.showAlert(message: error)
        }
        viewModel.items.observe(on: self) { [weak self] (repoItems) in
            self?.tableView.reloadData()
        }
    }
    
}

extension RepositoriesViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == viewModel.items.value.count - 4 {
            viewModel.loadNextPage()
        }
        
        let item = viewModel.item(at: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier, for: indexPath) as? RepositoryTableViewCell else {
            fatalError("Can't dequeue RepositoryTableViewCell ")
        }
        cell.fill(with: item)
        return cell
    }
}

extension RepositoriesViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelect(item: viewModel.item(at: indexPath))
    }
}

extension RepositoriesViewController: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.searchTextField.text {
            viewModel.search(text)
        }
    }
}

extension RepositoriesViewController
{
    static func create(with viewModel: RepositoriesViewModel) -> RepositoriesViewController {
        let viewController = RepositoriesViewController.instantiateViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}

