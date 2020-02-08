//
//  CommitsViewController.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/8/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

final class CommitsViewController: UIViewController, StoryboardInstantiable, Alertable
{
    var viewModel: CommitsViewModel!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        self.title = viewModel.title
    }
    
    func bind(to viewModel: CommitsViewModel) {
        viewModel.error.observe(on: self) { [weak self] error in
            guard error.isEmpty == false else { return }
            self?.showAlert(message: error)
        }
        viewModel.items.observe(on: self) { [weak self] (repoItems) in
            self?.tableView.reloadData()
        }
    }
}

extension CommitsViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == viewModel.items.value.count - 4 {
            viewModel.loadNextPage()
        }

        let item = viewModel.item(at: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommitTableViewCell.identifier, for: indexPath) as? CommitTableViewCell else {
            fatalError("Can't dequeue CommitTableViewCell")
        }
        cell.fill(with: item)
        return cell
    }
}

extension CommitsViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CommitsViewController
{
    static func create(with viewModel:CommitsViewModel) -> CommitsViewController {
        let viewController = CommitsViewController.instantiateViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
