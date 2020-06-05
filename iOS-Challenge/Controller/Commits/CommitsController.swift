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
    //Made it internal in order to access from testCase
    let dataSource = CommitsTableViewDataSource()
    
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
        view.tblView.dataSource = dataSource
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
    
    //Made it internal in order to access from testCase
    func processFetched( jsonCommits: [JSON] ) {
        var commits = [Commit]()
        jsonCommits.forEach { (commit) in
            // TODO: Solve Force TRY! in all source code
            let commitJsonObj = commit["commit"]
            let commitObj = try! JSONDecoder().decode(Commit.self, from: commitJsonObj.rawData())
            commits.append(commitObj)
        }
        self.dataSource.commits = commits
        (view as! CommitsView).tblView.reloadData()
    }
}
