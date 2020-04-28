//
//  RepositoriesSearchVC.swift
//  iOS-Challenge
//
//  Created by Saeed Dehshiri on 4/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class RepositoriesSearchVC: BaseVC {
    
    private var viewModel : RepositoriesSearchVM!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RepositoriesSearchVM(self)
        tableview.register(UINib(nibName: "RepositoryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "RepositoryTableViewCellID")
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableview.reloadData()
        }
    }
    
}


extension RepositoriesSearchVC: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCellID", for: indexPath) as! RepositoryTableViewCell
        cell.setData(data: viewModel.items[indexPath.row])
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            if !text.isEmpty {
                viewModel.getData(q: text)
                view.endEditing(true)
            }
        }
    }
    
}
