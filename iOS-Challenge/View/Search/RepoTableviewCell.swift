//
//  RepoCell.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class RepoTableviewCell: UITableViewCell {

    //MARK:- Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    init(repo: GitRepo) {
        super.init(style: .default, reuseIdentifier: nil)
        setupViews()
        nameLabel.text = repo.name
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    private func setupViews() {
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    //MARK:- Views
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "نام ندارد."
        return label
    }()
}
