//
//  SearchView.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit


class SearchView: UIView {
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    //MARK:- Setups
    private func setupViews() {
        addSubview(tblView)
        tblView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK:- Views
    let tblView: UITableView = {
        let tbl = UITableView()
        if #available(iOS 13.0, *) {
            tbl.backgroundColor = .systemBackground
        } else {
            tbl.backgroundColor = .white
        }
        return tbl
    }()
}
