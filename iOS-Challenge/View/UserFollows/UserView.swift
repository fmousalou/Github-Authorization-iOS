//
//  UserView.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class UserView: UIView {
    private let user: User?
    //MARK: Init
    init(user: User?) {
        self.user = user
        super.init(frame: .zero)
        setupView()
        addViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.roundedImage()
    }
    
    //MARK: Setups
    private func setupView() {
        backgroundColor = .white
        nameLabel.text = user?.name
        companyLabel.text = user?.company
        locationLabel.text = user?.location
        bioLabel.text = user?.bio
        
        // Assign user avatar
        self.imageView.sd_setImage(with: user?.avatar_url)
    }
    
    private func addViews() {
        // Imageview
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(120)
            make.top.equalTo(snp_topMargin).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        // Labels
        self.addSubview(labelStack)
        setupLabelStack()
        labelStack.snp.makeConstraints { (make) in
            make.leading.equalTo(self.imageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(self.imageView.snp.height)
            make.top.equalTo(self.imageView.snp.top)
        }
        
        // Bio Label
        self.addSubview(bioLabel)
        bioLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(imageView.snp.leading)
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.trailing.equalTo(self.labelStack.snp.trailing)
            make.height.equalTo(120)
        }
        
        // User Follows
        let followsView = UserFollowsView(followers: user?.followers,
                                      following: user?.following)
        self.addSubview(followsView)
        followsView.snp.makeConstraints { (make) in
            make.top.equalTo(bioLabel.snp_bottomMargin)
            make.height.equalTo(100)
            make.leading.equalTo(bioLabel.snp_leadingMargin)
            make.trailing.equalTo(bioLabel.snp_trailingMargin)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupLabelStack() {
        labelStack.addArrangedSubview(nameLabel)
        labelStack.addArrangedSubview(companyLabel)
        labelStack.addArrangedSubview(locationLabel)
    }
    
    //MARK:- Views
    private lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "user_placeholder")
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let labelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    //MARK:- Labels
    //Name Label
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = "No Name"
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    //company Label
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = "No Company"
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    //location Label
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = "No location"
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    //bio Label
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = "No bio"
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
}
