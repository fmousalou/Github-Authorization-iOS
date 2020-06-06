//
//  UserView.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class ProfileView: UIView {
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
        nameTF!.text = user?.name
        companyTF!.text = user?.company
        locationTF!.text = user?.location
        bioTV.text = user?.bio
        
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
        self.addSubview(textFieldsStack)
        setupLabelStack()
        textFieldsStack.snp.makeConstraints { (make) in
            make.leading.equalTo(self.imageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(self.imageView.snp.height)
            make.top.equalTo(self.imageView.snp.top)
        }
        
        // Bio Label
        self.addSubview(bioTV)
        bioTV.snp.makeConstraints { (make) in
            make.leading.equalTo(imageView.snp.leading)
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.trailing.equalTo(self.textFieldsStack.snp.trailing)
            make.height.equalTo(120)
        }
        
        // User Follows
        let followsView = UserFollowsView(followers: user?.followers,
                                      following: user?.following)
        self.addSubview(followsView)
        followsView.snp.makeConstraints { (make) in
            make.top.equalTo(bioTV.snp_bottomMargin)
            make.height.equalTo(100)
            make.leading.equalTo(bioTV.snp_leadingMargin)
            make.trailing.equalTo(bioTV.snp_trailingMargin)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupLabelStack() {
        textFieldsStack.addArrangedSubview(nameTF!)
        textFieldsStack.addArrangedSubview(companyTF!)
        textFieldsStack.addArrangedSubview(locationTF!)
    }
    
    //MARK:- Views
    private lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "user_placeholder")
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let textFieldsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .green
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    // MARK:- TextFields
    // TODO: Use Factory Pattern
    // Name TextField
    private weak var nameTF: UITextField? = {
        let tf =  UITextField()
        tf.isUserInteractionEnabled = false
        tf.placeholder = "Name"
        tf.returnKeyType = .done
        tf.autocorrectionType = .no
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.borderStyle = .roundedRect
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    // Company TextField
    private weak var companyTF: UITextField? = {
        let tf =  UITextField()
        tf.isUserInteractionEnabled = false
        tf.placeholder = "Company"
        tf.returnKeyType = .done
        tf.autocorrectionType = .no
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.borderStyle = .roundedRect
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    // Location TextField
    private weak var locationTF: UITextField? = {
        let tf =  UITextField()
        tf.isUserInteractionEnabled = false
        tf.placeholder = "Location"
        tf.returnKeyType = .done
        tf.autocorrectionType = .no
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.borderStyle = .roundedRect
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    // Bio TextView
    let bioTV: UITextView = {
        let tv =  UITextView()
        tv.text = "Biography"
        tv.font = UIFont.italicSystemFont(ofSize: 18)
        tv.returnKeyType = .done
        // Round it
        tv.layer.borderWidth = 1
        tv.layer.cornerRadius = 10
        tv.clipsToBounds = true
        tv.isEditable = false
        tv.isSelectable = false
        return tv
    }()
}
