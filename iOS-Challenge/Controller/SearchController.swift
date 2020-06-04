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
    
    var arr = [GitRepo(name: "iMamad repo"), GitRepo(name: "iSeyyed repo")]
    private var searchView = SearchView()
    
    override func loadView() {
        self.view = searchView
        setupViews()
    }
    
    private func setupViews() {
        searchView.tblView.delegate = self as UITableViewDelegate
        searchView.tblView.dataSource = self as UITableViewDataSource
        searchView.tblView.register(RepoTableviewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

extension SearchController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? RepoTableviewCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = arr[indexPath.item].name

        return cell
    }
}



struct GitRepo {
    var name: String?
}
