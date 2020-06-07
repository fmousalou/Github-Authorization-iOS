//
//  UserView.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    //MARK: Properties
    var user: User? {
        didSet {
            nameTF.text = user?.name
            companyTF.text = user?.company
            locationTF.text = user?.location
            bioTV.text = user?.bio
            
            // Assign user avatar
            self.imageView.sd_setImage(with: user?.avatar_url)
            
            // Set user follows
            self.followsView.user = user
        }
    }
    var textFields: [UITextField] {
        get {
            let stackViews = self.textFieldsStack.arrangedSubviews
            var tfsArrray = [UITextField]()
            for view in stackViews {
                if let tf = view as? UITextField {
                    tfsArrray.append(tf)
                }
            }
            return tfsArrray
        }
    }
    var bioText: String { bioTV.text }
    var editable: Bool = false {
        didSet {
            // Make TextFields Editable
            let textFields = self.textFields
            textFields.forEach {
                $0.isUserInteractionEnabled = editable
                $0.borderStyle = editable ? .roundedRect : .none
            }
            
            // Make BioTextView ediatable
            self.bioTV.isEditable = editable
            
            // Activate name TextField
            textFields[0].becomeFirstResponder()
        }
    }
    
    //MARK: Init
    init() {
        super.init(frame: .zero)
        setupView()
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
        // Imageview
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(120)
            make.top.equalTo(snp_topMargin).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        // Labels
        self.addSubview(textFieldsStack)
        setupTextFieldsStack()
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
        
        self.addSubview(followsView)
        followsView.snp.makeConstraints { (make) in
            make.top.equalTo(bioTV.snp_bottomMargin)
            make.height.equalTo(100)
            make.leading.equalTo(bioTV.snp_leadingMargin)
            make.trailing.equalTo(bioTV.snp_trailingMargin)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupTextFieldsStack() {
        textFieldsStack.addArrangedSubview(nameTF)
        textFieldsStack.addArrangedSubview(companyTF)
        textFieldsStack.addArrangedSubview(locationTF)
    }
    
    //MARK:- Views
    // Follows Subview
    var followsView = UserFollowsView()
    
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "user_placeholder")
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let textFieldsStack: UIStackView = {
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
    private let nameTF: UITextField = {
        let tf =  UITextField()
        tf.isUserInteractionEnabled = false
        tf.placeholder = "Name"
        tf.returnKeyType = .done
        tf.autocorrectionType = .no
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    // Company TextField
    private let companyTF: UITextField = {
        let tf =  UITextField()
        tf.isUserInteractionEnabled = false
        tf.placeholder = "Company"
        tf.returnKeyType = .done
        tf.autocorrectionType = .no
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    // Location TextField
    private let locationTF: UITextField = {
        let tf =  UITextField()
        tf.isUserInteractionEnabled = false
        tf.placeholder = "Location"
        tf.returnKeyType = .done
        tf.autocorrectionType = .no
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    // Bio TextView
    private let bioTV: UITextView = {
        let tv =  UITextView()
        tv.text = "Biography"
        tv.font = UIFont.italicSystemFont(ofSize: 18)
        tv.returnKeyType = .done
        tv.isEditable = false
        tv.isSelectable = false
        // Round it
        tv.layer.borderWidth = 0.5
        tv.layer.cornerRadius = 10
        tv.clipsToBounds = true
        return tv
    }()
}
