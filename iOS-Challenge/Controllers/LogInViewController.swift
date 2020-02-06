//
//  ViewController.swift
//  iOS-Challenge
//
//  Created by Farshad Mousalou on 1/28/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
//import Alamofire
import RxSwift
import RxGesture



@available(iOS 13.0, *)
class LogInViewController: UIViewController {
    
    @IBOutlet var loginWithGitHubButton: UIButton!
    @IBOutlet var logoImageView: UIImageView!
    
    private var disposeBag = DisposeBag()
    
    private lazy var viewModel :LogInViewModel = {
        return LogInViewModel()
    }()
    
    //MARK: - initializer
    deinit {
        NotificationCenter.default.removeObserver(self, name: .authorized, object: nil)
    }
    
    // MARK: - Default Delegates
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        UIConfig()
        bindingFrom()
        bindingTo()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.authorizedSuccessfully(_:)), name: .authorized, object: nil)
        
    }
    
    // MARK: - Set UI
    
    private func UIConfig() {
        logoImageView.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    // MARK: - Bind From ViewModel
    
    private func bindingFrom() {
        viewModel
            .message
            .asObservable()
            .filter({ $0 != nil})
            .subscribe(onNext:{ [unowned self] messageSet in
                guard let messageSet = messageSet else{ return }
                self.showAlert(title: messageSet.0, message: messageSet.1)
            }).disposed(by: disposeBag)
        
    }
    
    
    // MARK: - Bind To ViewModel
    
    private func bindingTo() {
        loginWithGitHubButton
            .rx
            .tap
            .subscribe(onNext:{ items in
                // create url
                guard var urlComponent = URLComponents(string: "https://github.com/login/oauth/authorize") else { return }
                // add parameters
                urlComponent.queryItems = [
                    URLQueryItem(name: "client_id", value: clientId),
                    URLQueryItem(name: "redirect_uri", value: redirectURL),
                    URLQueryItem(name: "scope", value: "repo"),
                    URLQueryItem(name: "state", value: state)
                ]
                
                // convert to url and open link
                do{
                    let finalURL = try urlComponent.asURL()
                    UIApplication.shared.open(finalURL,options: [:]) { (result) in   print(result) }
                }catch{
                    self.showAlert(title: "Error", message: "Somthing Happend please Try again.")
                }
                
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Custome Methods
    
    @objc func authorizedSuccessfully(_ notification:Notification){
        if let object = notification.object as? [String:String]{
            if let code = object["code"]{
            viewModel.callLogin(code:code)
            }}
//        if let rootNavigationController = self.storyboard?.instantiateViewController(identifier: "rootNavigation") {
//            UIApplication.shared.setRoot(viewController: rootNavigationController)
//        }
    }
    
    
    
}

