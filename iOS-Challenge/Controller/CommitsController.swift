//
//  CommitsController.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import Moya
import NVActivityIndicatorView
import SwiftyJSON

class CommitsController: UIViewController, NVActivityIndicatorViewable, UITableViewDelegate {
    
    //MARK:- Variables
    private let url: String
    private var commits = [Commit]() {
        didSet {
            (view as! CommitsView).tblView.reloadData()
        }
    }
    
    //MARK:- Init
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- LifeCycle
    override func loadView() {
        let vw = CommitsView()
        self.view = vw
        setupViews(view: vw)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCommits()
    }
    
    //MARK:- Setups
    private func setupViews(view: CommitsView) {
        self.title = "Commits"
        view.tblView.delegate = self as UITableViewDelegate
        view.tblView.dataSource = self as UITableViewDataSource
        view.tblView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    //MARK:- Network Functions
    private func fetchCommits() {
        let service = githubService.init()
        let path = url.commitsURLPath!
        startAnimating(message: "Connecting to the server")
        service.request(.commits(commitPath: path)) {
            [weak self]
            (result) in
            guard let sSelf = self else { return}
            switch result {
            case .success(let response):
                if let json = JSON(response.data).array {
                    sSelf.processFetched(jsonCommits: json)
                }
            case .failure:
                Toast.shared.showConnectionError()
            }
            sSelf.stopAnimating()
        }
    }
    
    private func processFetched( jsonCommits: [JSON] ) {
        var commits = [Commit]()
        jsonCommits.forEach { (commit) in
            // TODO: Solve Force TRY! in all source code
            let commitJsonObj = commit["commit"]
            let commitObj = try! JSONDecoder().decode(Commit.self, from: commitJsonObj.rawData())
            commits.append(commitObj)
        }
        self.commits = commits
    }
}

// Tableview
extension CommitsController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Make custom class
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = commits[indexPath.row].committer?.name
        cell.detailTextLabel?.text = commits[indexPath.row].message
        return cell
    }
}
