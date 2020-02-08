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
    fileprivate var repositoryListFactory: RepositoryListFactory!
    
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
        setupNavbarItems()
        searchController.searchBar.searchTextField.becomeFirstResponder()
    }
    
    func bind(to viewModel: RepositoriesViewModel) {
        viewModel.error.observe(on: self) { [weak self] error in
            guard error.isEmpty == false else { return }
            self?.showAlert(message: error)
        }
        viewModel.items.observe(on: self) { [weak self] (repoItems) in
            self?.tableView.reloadData()
        }
        viewModel.route.observe(on: self) { [weak self] (route) in
            switch route{
            case .initial: break
            case .showCommits(let repository):
                self?.navigateToCommits(for: repository)
            case .profile:
                self?.navigateToUserProfile()
            case .logout:
                self?.navigateToAuthorization()
                break
            }
        }
    }
    func navigateToAuthorization() {
        let authorizationViewController = repositoryListFactory.makeAuthorizationViewController()
        authorizationViewController.modalPresentationStyle = .fullScreen
        let viewcontrollers = [authorizationViewController] as [UIViewController]
        navigationController?.setViewControllers(viewcontrollers, animated: true)
    }
    
    func navigateToCommits(for repository: Repository) {
        let viewController = repositoryListFactory.makeCommitsViewController(with: repository)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func navigateToUserProfile()  {
        let viewController = repositoryListFactory.makeProfileViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setupNavbarItems() {
        let profileItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(showProfile))
        let logout = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutUser))
        navigationItem.leftBarButtonItem = logout
        navigationItem.rightBarButtonItem = profileItem
    }
    
    @objc func showProfile() {
        viewModel.showProfile()
    }
    
    @objc func logoutUser() {
        showAlert(title: "", message: "Are you sure about log out?", preferredStyle: .alert) { (_) in
            self.viewModel.logout()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
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
    static func create(with viewModel: RepositoriesViewModel, repositoryListFactory: RepositoryListFactory) -> RepositoriesViewController {
        let viewController = RepositoriesViewController.instantiateViewController()
        viewController.repositoryListFactory = repositoryListFactory
        viewController.viewModel = viewModel
        return viewController
    }
}


protocol RepositoryListFactory {
    func makeCommitsViewController(with repo: Repository) -> CommitsViewController
    func makeProfileViewController() -> ProfileViewController
    func makeAuthorizationViewController() -> AuthorizationViewController
}
