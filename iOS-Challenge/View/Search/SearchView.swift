//
//  SearchView.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class SearchView: UIView {
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    //MARK: Setups
    private func setupViews() {
        tblView.tableFooterView = UIView()
        addSubview(tblBackground)
        tblView.backgroundView = tblBackground
        addSubview(tblView)
        tblView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK:- Views
    let tblView: UITableView = {
        let tbl = UITableView()
        tbl.rowHeight = 70
        if #available(iOS 13.0, *) {
            tbl.backgroundColor = .systemBackground
        } else {
            tbl.backgroundColor = .white
        }
        return tbl
    }()
    
    let tblBackground: UILabel = {
        let backgroundViewLabel = UILabel(frame: .zero)
        backgroundViewLabel.textColor = .darkGray
        backgroundViewLabel.numberOfLines = 0
        backgroundViewLabel.textAlignment = .center
        backgroundViewLabel.text = "Use top sarch bar \nto find your favorite Repo 😍"
        return backgroundViewLabel
    }()
    
    let leftBarBtn: UIBarButtonItem = {
        let barBtn =  UIBarButtonItem(image: UIImage(named: "user_placeholder"),
                                      style: .plain,
                                      target: nil,
                                      action: #selector(SearchController.showUserInfoPage))

        barBtn.tintColor = .white
        return barBtn
    }()
}
