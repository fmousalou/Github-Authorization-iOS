//
//  Toast.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import SwiftMessages
import SnapKit

class Toast {
    static let shared = Toast()
    private var config = SwiftMessages.defaultConfig
    init() {
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: .alert)
        config.duration = .seconds(seconds: 5)
        config.dimMode = .none
        config.preferredStatusBarStyle = .default
        config.ignoreDuplicates = false
    }
    
    func showToast(title:String, body: String, theme: Theme, iconTxt:String){
        SwiftMessages.hide()
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(theme)
        view.configureDropShadow()
        view.bodyLabel?.textColor = (theme == .warning) ? .black : .white
        view.configureContent(title: title, body: body, iconText: iconTxt)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        
        
        view.button?.setTitle("باشه!", for: .normal)
        let btnAction : (((UIButton) -> Void)?) = { _ in
            SwiftMessages.hide()
        }
        view.buttonTapHandler = btnAction
        SwiftMessages.show(config: config, view: view)
    }
    
    func showConnectionError() {
        self.showToast(title: "", body: "اتصال با سرور برقرار نشد.", theme: .error, iconTxt: "🙁")
    }
    
    func showIn(body: String, icon: String = "🙂", theme: Theme = .warning) {
        self.showToast(title: "", body: body, theme: theme, iconTxt: icon)
    }
    
    
    // MARK:- Modal
    private lazy var modalConfig: SwiftMessages.Config = {
        var config = SwiftMessages().defaultConfig
        config.duration = .forever
        config.dimMode = .gray(interactive: true)
        config.presentationStyle = .center
        config.presentationContext = .automatic
        config.preferredStatusBarStyle = .lightContent
        return config
    }()
    private lazy var descriptionTxtView: UITextView = {
        let tv = UITextView()
        tv.textAlignment = .right
        tv.textColor = .darkText
        tv.backgroundColor = .clear
        tv.layer.borderWidth = 1
        tv.layer.cornerRadius = 10
        tv.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        tv.isEditable = false
        return tv
    }()
    private lazy var descriptionModal: MessageView = {
        let modealView = MessageView.viewFromNib(layout: .centeredView)
        modealView.configureTheme(.info)
        modealView.configureDropShadow()
        let btnAction : (((UIButton) -> Void)?) = { _ in
            SwiftMessages.hide()
        }
        modealView.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        modealView.configureContent(title: "توضیحات", body: nil, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "بستن", buttonTapHandler: btnAction)
        (modealView.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        
        modealView.addSubview(self.descriptionTxtView)
        descriptionTxtView.snp.makeConstraints { (make) in
            make.top.equalTo(modealView.titleLabel!.snp.bottom).offset(10)
            make.bottom.equalTo(modealView.button!.snp.top).offset(-10)
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalToSuperview().multipliedBy(0.73)
        }
        return modealView
    }()
    
    func showModal(description: String) {
        descriptionTxtView.text = description
        descriptionTxtView.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        SwiftMessages.show(config: modalConfig, view: descriptionModal)
    }
}

