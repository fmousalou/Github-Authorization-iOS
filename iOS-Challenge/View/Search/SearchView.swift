//
//  SearchView.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import SDWebImage

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
        backgroundViewLabel.text = "Use the top sarch bar \nand find your favorite Repo 😍"
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


extension UIImage {
    enum ContentMode {
        case contentFill
        case contentAspectFill
        case contentAspectFit
    }

    func resize(withSize size: CGSize, contentMode: ContentMode = .contentAspectFill) -> UIImage? {
        let aspectWidth = size.width / self.size.width
        let aspectHeight = size.height / self.size.height

        switch contentMode {
        case .contentFill:
            return resize(withSize: size)
        case .contentAspectFit:
            let aspectRatio = min(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        case .contentAspectFill:
            let aspectRatio = max(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        }
    }

    private func resize(withSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
