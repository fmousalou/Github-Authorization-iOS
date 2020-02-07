//
//  RepositoriesViewController.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/5/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController, StoryboardInstantiable
{
    var viewModel: RepositoriesViewModel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
    }
}

extension RepositoriesViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension RepositoriesViewController: UITableViewDelegate
{
    
}

extension RepositoriesViewController
{
    static func create(with viewModel: RepositoriesViewModel) -> RepositoriesViewController {
        let viewController = RepositoriesViewController.instantiateViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
