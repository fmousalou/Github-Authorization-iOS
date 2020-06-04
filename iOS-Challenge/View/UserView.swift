//
//  UserView.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class UserView: UIView {
    private let user: User?
    
    //MARK:- Init
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
    
    //MARK:- Setups
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
    }
    
    private func setupLabelStack() {
        labelStack.addArrangedSubview(nameLabel)
        labelStack.addArrangedSubview(companyLabel)
        labelStack.addArrangedSubview(locationLabel)
    }
    
    //MARK:- Views
    //MARK:- Imageviews
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

//TODO: Follow(er)(ing)s view Object
class UserFollowsView: UIView {
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setups
    private func setupView() {
        backgroundColor = .white
        
    }
    
    //MARK:- Views
    //MARK:- Stacks
    private var iconStack: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }
    private var labelStack: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }
    private var containerStack: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }
    
    //MARK:- Imageviews
    private lazy var followerImg: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "follower_icon")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    private lazy var followingImg: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "following_icon")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    
    //MARK:- Labels
    //flwing Label
    private lazy var flwingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = "No following"
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    //flwer Label
    private lazy var flwerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = "No follower"
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
}



